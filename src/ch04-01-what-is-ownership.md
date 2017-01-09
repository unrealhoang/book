## What is Ownership?
## Ownership là gì?

Tính năng trung tâm của Rust là *ownership*. Nó là tính năng rất đơn giản
để giải thích, nhưng nó có ảnh hưởng rất sâu tới toàn bộ phần còn lại của
ngôn ngữ.

Tất cả chương trình đều phải quản lý cách mà chúng sử dụng bộ nhớ của máy tính
khi chúng chạy. Một số ngôn ngữ có bộ thu gom rác sẽ liên tục tìm kiếm những
mảng bộ nhớ không còn được dùng tới khi chương trình đang chạy, hoặc một số khác,
người lập trình viên phải cấp phát và giải phóng bộ nhớ một cách rõ ràng. Rust
dùng một cách tiếp cận khác: bộ nhớ sẽ được quản lý thông qua một hệ thống ownership
với một tập hợp các quy tắc mà trình biên dịch (compiler) sẽ kiểm tra ở lúc biên
dịch. Chương trình của bạn sẽ không phải trả bất kì chi phí (về mặt tài nguyên)
trong lúc thực thi cho bất kì tính năng nào của ownership.

Vì ownership là một khái niệm mới cho nhiều lập trình viên, sẽ mất một thời
gian để bạn có thể làm quen với nó. Tin tốt là: bạn càng có nhiều kinh nghiệm
với Rust và các luật lệ của hệ thống ownership, thì bạn càng có khả viết ra
code vừa an toàn và vừa hiệu quả. Hãy nắm lấy nó!

Một khi bạn đã hiểu ownership, bạn sẽ có một nền tảng tốt để hiểu những tính năng
làm nên sự đặc biệt của Rust. Trong chương này, chúng ta sẽ học ownership bằng
cách đi qua những ví dụ, tập trung vào một cấu trúc dữ liệu vô cùng quen thuộc:
string (chuỗi).

<!-- PROD: START BOX -->

> ### Stack và Heap
>
> Trong nhiều ngôn ngữ lập trình, chúng ta không cần phải nghĩ về bộ nhớ stack
> và bộ nhớ heap một cách thường xuyên. Nhưng trong những ngôn ngữ lập trình
> hệ thống như Rust, việc một giá trị  nằm trên stack hay nằm trên heap có ảnh
> hưởng rất lớn tới việc ngôn ngữ hoạt động như thế nào và tại sao chúng ta phải
> lựa chọn trong một số tình huống. Chúng ta sẽ giải thích những phần mà ownership
> có liên quan tới bộ nhớ stack và heap, và đây là lời giải thích đại ý.

> Cả bộ nhớ stack và heap đều là những phần của bộ nhớ mà có thể được sử dụng
> bởi code của chúng ta tại thời gian thực thi, nhưng chúng được cấu tạo bằng
> những cách khác nhau. Bộ nhớ stack lưu trữ giá trị theo thứ tự chúng nhận được
> và xoá chúng theo thứ tự ngược lại. Đây chính là ví dụ cho thuật ngữ *last in,
> first out* (*vào sau, ra trước*). Hãy nghĩ tới một chồng dĩa: khi bạn thêm dĩa
> vào chồng dĩa này, bạn bỏ lên trên cùng, và khi bạn cần dĩa thì bạn sẽ lấy ra
> từ trên cùng. Thêm vào hay lấy ra từ giữa chồng dĩa sẽ không dễ như vậy! Thêm
> dữ liệu vào stack sẽ được gọi là *push* (*đẩy vào*), và lấy dữ liệu ra sẽ được
> gọi là *pop* (*rút ra*).
>
> Bộ nhớ stack rất nhanh vì cách nó truy xuất dữ liệu: nó không cần phải kiếm xung
> quanh để thêm dữ liệu mới hay để lấy dữ liệu cũ ra; chỗ cần thêm/lấy ra luôn luôn
> nằm trên đỉnh. Một đặc tính khác làm cho stack nhanh là vì tất cả dữ liệu nằm
> trên stack cần phải có kích thước cố định và được biết trước từ lúc biên dịch.
>
> Cho những dữ liệu mà chúng ta không thể biết kích thước của chúng ở lúc biên dịch,
> hoặc là kích thước của chúng có thể thay đổi, chúng ta có thể lưu trữ dữ liệu
> trên heap. Bộ nhớ heap thì ít được sắp xếp hơn: khi chúng ta nhét dữ liệu lên bộ
> nhớ heap, chúng ta sẽ hỏi một kích thước bộ nhớ nhất định. Hệ điều hành sẽ tìm
> một chỗ trống đủ lớn trong heap, đánh dấu phần bộ nhớ đó là đã được sử dụng, và
> trả về cho chúng ta một con trỏ tới vị trí đó. Quá trình này được gọi là *cấp
> phát bộ nhớ trên heap*, và đôi khi chúng ta gọi tắt là "cấp phát" (allocate).
> Nhét dữ liệu vào stack không được xem là cấp phát. Bởi vì con trỏ là một giá trị
> cố định và biết trước kích thước, chúng ta có thể lưu con trỏ trên stack, nhưng
> khi chúng ta cần dữ liệu thực sự, chúng ta cần đi đến địa chỉ mà con trỏ trỏ tới.
>
> Nghĩ về việc ngồi ở nhà hàng. Khi bạn đến, bạn sẽ báo là nhóm của bạn gồm bao
> nhiêu người, và bồi bàn sẽ tìm một bàn trống mà sẽ đủ chỗ cho nhóm của bạn, và
> dẫn bạn tới bàn đó. Nếu nhóm của bạn có người đến trễ, họ chỉ cần hỏi là bạn ngồi
> bàn nào và tới bàn đó ngồi.
>
> Truy cập dữ liệu trong heap sẽ chậm hơn vì chúng ta phải đi theo con trỏ để đến
> vị trí cần truy cập. Đồng thời, CPU sẽ nhanh hơn nếu nó ít phải nhảy giữa các
> vùng bộ nhớ hơn. Tiếp tục ví dụ khi nãy, tưởng tượng người bồi bạn ở nhà hàng
> mà phải nhận gọi món cho nhiều bàn. Nó sẽ hiệu quả nhất nếu như anh ta có thể
> ghi tất cả các món của một bàn trước khi chuyển qua bàn khác. Ghi món của bàn
> A, xong sau đó sang ghi món của bàn B, rồi lại ghi 1 món khác của bàn A, rồi lại
> quay lại bạn B để ghi món sẽ chậm hơn rất nhiều. Cũng như vậy, bộ nhớ sẽ làm việc
> của chúng nhanh hơn nếu chúng thực thi trên vùng bộ nằm gần nhau (giống như trên
> stack), hơn là các vùng bộ nhớ nằm xa nhau (khả năng có thể xảy ra trên heap).
> Cấp phát một vùng dữ liệu với kích thước lớn trên heap cũng sẽ rất tốn thời gian.
>
> Khi code của chúng ta gọi một hàm, giá trị truyền vào cho hàm (kể cả con trỏ tới
> dữ liệu thực sự trên heap) và những biến cục bộ của hàm sẽ được đẩy vào stack.
> Khi hàm kết thúc, những giá trị này sẽ được rút ra khỏi stack.
>
> Theo dõi những phần nào của code sử dụng dữ liệu trong heap, giảm thiểu tối đa
> số lượng dữ liệu trùng lặp trên heap, và dọn dẹp những dữ liệu trên heap mà chúng
> ta không sử dụng tới để chúng ta không bị hết bộ nhớ - đó là tất cả những vấn đề
> mà ownership giải quyết. Một khi bạn hiểu ownership, bạn sẽ không cần phải suy
> nghĩ về stack và heap một cách thường xuyên, nhưng hiểu rằng quản lý dữ liệu trên
> bộ nhớ heap là lý do mà ownership tồn tại sẽ giúp giải thích tại sao nó lại hoạt
> động như vậy.

<!-- PROD: END BOX -->

### Những quy tắc Ownership

Đầu tiên, hãy nhìn vào những quy tắc của Ownership. Hãy giữ nó trong đâu khi chúng
ta xem qua những ví dụ sẽ thể hiện những quy tắc này:

> 1. Mỗi giá trị trong Rust có 1 biến được gọi là *owner* của giá trị đó.
> 2. Chỉ có thể có một *owner* tại một thời điểm.
> 3. Khi owner đi ra khỏi phạm vi hoạt động (scope), giá trị đó sẽ bị huỷ (drop).

### Phạm vi hoạt động của biến

Chúng ta đã đi qua một ví dụ về chương trình Rust trong chương hướng dẫn. Bây giờ,
sau khi chúng ta đã biết những cú pháp căn bản, chúng ta sẽ không đưa tất cả những
`fn main() {` vào những ví dụ tiếp theo, nếu như bạn dõi theo đây, bạn sẽ phải
tự đưa những ví dụ tiếp theo vào trong hàm `main`. Như vậy sẽ giúp cho những ví
dụ chính xác hơn, giúp chúng ta tập trung vào nội dung chính thay vì những thành
phần bắt buộc.

Ví dụ đầu tiên về ownership, chúng ta sẽ xem qua phạm vi (*scope*) của một số biến.
Scope là phạm vi trong chương trình mà trong đó một đối tượng là có hiệu lực. Giả
sử chúng ta có một biến như sau:

```rust
let s = "hello";
```

Biến `s` chỉ tới một chuỗi hằng - giá trị của chuỗi này được viết cứng vào nội
dung code của chương trình của chúng ta. Biến này có hiệu lực từ lúc nó được
khai báo cho tới kết thúc của *scope* hiện tại. Đó là:

```rust
{                      // s không có hiệu lực ở đây, nó chưa được khai báo
    let s = "hello";   // s có hiệu lực bắt đầu từ đây

    // Làm gì đó với s
}                      // scope này tới đây là hết, và s không còn có hiệu lực nữa
```

Nói cách khác, có 2 thời điểm quan trọng ở đây:

- Khi `s` được khai báo trong scope, nó có hiệu lực.
- Nó giữ hiệu lực của nó cho tới khi nó *ra khỏi scope*.

Tại thời điểm này, mọi thứ vẫn giống với những ngôn ngữ khác. Bây giờ hãy tiếp
tục ví dụ sau bằng cách giới thiệu về kiểu `String`.

### Kiểu `String`

Để minh hoạ các quy tắc của ownership, chúng ta cần một kiểu dữ liệu mà phức tạp
hơn những kiểu mà chúng ta đã học ở Chương 3. Tất cả những kiểu dữ liệu chúng ta
đã xem qua đều được lưu trữ trên stack và được đẩy ra khỏi stack khi scope của
chúng kết thúc, nhưng chúng ta muốn xem dữ liệu mà được lưu trữ ở trên heap và
tìm hiểu cách mà Rust biết lúc nào thì cần dọn dẹp phần dữ liệu đó.

Chúng ta sẽ dùng `String` làm ví dụ ở đây và tập trung vào phần của `String` mà
có liên quan tới ownership. Những khía cạnh này cũng sẽ áp dụng cho các kiểu dữ
liệu phức tạp khác được cung cấp trong thư viện chuẩn hay do bạn tạo ra. Chúng ta
sẽ tìm hiểu kĩ hơn về đặc điểm của `String` trong Chương 8.

Chúng ta đã thấy chuỗi hằng - giá trị chuỗi được hard-code vào trong chương
trình. Chuỗi hằng rất tiện lợi, nhưng không phải lúc nào chúng cũng phù hợp với
những tình huống mà chúng ta muốn sử dụng văn bản. Một là, chuỗi hằng là bất biến
(immutable) không tay đổi được. Hai là, không phải giá trị chuỗi nào chúng ta cũng
có thể biết được ở thời điểm chúng ta viết chương trình: phải làm sao nếu chúng ta
muốn lấy giá trị được nhập bởi người dùng và lưu trữ nó?

Cho những trường hợp như vậy, Rust có một kiểu dữ liệu khác là `String`. Kiểu dữ
liệu này được cấp phát trên heap, và như vậy, nó có thể lưu trữ được lượng văn bản
mà chúng ta không biết ở thời điểm biên dịch. Bạn có thể tạo `String` từ chuỗi hằng,
sử dụng hàm `from`, như sau:

```rust
let s = String::from("hello");
```

Dấu hai chấm kép (`::`) là một toán tử cho phép chúng ta chỉ ra hàm `from` của
kiểu dữ liệu `String`, thay vì phải dùng tên theo kiểu `string_from`. Chúng ta
sẽ bàn thêm về cú pháp này trong chương "Cú pháp hàm" và " chương "Module".

Kiểu chuỗi này *có thể* thay đổi được:

```rust
let mut s = String::from("hello");

s.push_str(", world!"); // push_str() thêm chuỗi hằng vào cuối chuỗi

println!("{}", s); // Dòng này sẽ in ra `hello, world!`
```

Vậy thì, sự khác biệt ở đây là gì? Tại sao `String` có thể bị thay đổi, còn chuỗi
hằng thì không thể? Sự khác biệt quy về làm thế nào 2 kiểu này tổ chức bộ nhớ.

### Bộ nhớ và Cấp phát

Trong trường hợp chuỗi hằng, vì chúng ta biết trước nội dung ở thời điểm biên dịch,
chuỗi văn bản được ghi thẳng vào file chạy cuối cùng. Điều này giúp cho chuỗi hằng
rất nhanh và hiệu quả. Nhưng những đặc tính đó chỉ vì tính bất biến của nó. Đáng
tiếc là, chúng ta không thể bỏ 1 đoạn bộ nhớ vào file nhị phân cho mỗi một đoạn
văn bản mà độ dài của chúng là không biết được ở thời điểm biên dịch, hoặc thậm
chí độ dài đó có thể thay đổi khi chương trình được chạy.

Với kiểu `String`, để hỗ trợ cho việc biến đổi, và cho phép nội dung văn bản có
thể tăng lên được, chúng ta cần cấp phát một vùng bộ nhớ ở heap, mà kích thước
không thể biết trước được tại thời điểm biên dịch, để giữ nội dung. Điều này mang
hai ý nghĩa:

1. Vùng nhớ phải được yêu cầu từ hệ điều hành trong lúc thực thi (runtime).
2. Chúng ta cần phải có cách trả vùng bộ nhớ này về lại cho hệ điều hành khi chúng
   ta đã sử dụng xong `String` đó.

That first part is done by us: when we call `String::from`, its implementation
requests the memory it needs. This is pretty much universal in programming
languages.

The second case, however, is different. In languages with a *garbage collector*
(GC), the GC will keep track and clean up memory that isn’t being used anymore,
and we, as the programmer, don’t need to think about it. Without GC, it’s the
programmer’s responsibility to identify when memory is no longer being used and
call code to explicitly return it, just as we did to request it. Doing this
correctly has historically been a difficult problem in programming. If we
forget, we will waste memory. If we do it too early, we will have an invalid
variable. If we do it twice, that’s a bug too. We need to pair exactly one
`allocate` with exactly one `free`.

Rust takes a different path: the memory is automatically returned once the
variable that owns it goes out of scope. Here’s a version of our scope example
from earlier using `String`:

```rust
{
    let s = String::from("hello"); // s is valid from this point forward

    // do stuff with s
}                                  // this scope is now over, and s is no longer valid
```

There is a natural point at which we can return the memory our `String` needs
back to the operating system: when `s` goes out of scope. When a variable goes
out of scope, Rust calls a special function for us. This function is called
`drop`, and it is where the author of `String` can put the code to return the
memory. Rust calls `drop` automatically at the closing `}`.

> Note: This pattern is sometimes called *Resource Acquisition Is
> Initialization* in C++, or RAII for short. The `drop` function in Rust will be
> familiar to you if you have used RAII patterns.

This pattern has a profound impact on the way that Rust code is written. It may
seem simple right now, but things can get tricky in more advanced situations
when we want to have multiple variables use the data that we have allocated on
the heap. Let’s go over some of those situations now.

#### Ways Variables and Data Interact: Move

There are different ways that multiple variables can interact with the same data
in Rust. Let’s take an example using an integer:

```rust
let x = 5;
let y = x;
```

We can probably guess what this is doing based on our experience with other
languages: “Bind the value `5` to `x`, then make a copy of the value in `x` and
bind it to `y`.” We now have two variables, `x` and `y`, and both equal `5`.
This is indeed what is happening since integers are simple values with a known,
fixed size, and these two `5` values are pushed onto the stack.

Now let’s look at the `String` version:

```rust
let s1 = String::from("hello");
let s2 = s1;
```

This looks very similar to the previous code, so we might assume that the way
it works would be the same: that the second line would make a copy of the value
in `s1` and bind it to `s2`. This isn’t quite what happens.

To explain this more thoroughly, let’s take a look at what `String` looks like
under the covers in Figure 4-1. A `String` is made up of three parts, shown on
the left: a pointer to the memory that holds the contents of the string, a
length, and a capacity. This group of data is stored on the stack. On the right
is the memory that holds the contents, and this is on the heap.

<figure>
<img alt="String in memory" src="img/trpl04-01.svg" class="center" style="width: 50%;" />

<figcaption>

Figure 4-1: Representation in memory of a `String` holding the value `"hello"`
bound to `s1`

</figcaption>
</figure>

The length is how much memory, in bytes, the contents of the `String` is
currently using. The capacity is the total amount of memory, in bytes, that the
`String` has gotten from the operating system. The difference between length
and capacity matters but not in this context, so for now, it’s fine to ignore
the capacity.

When we assign `s1` to `s2`, the `String` data itself is copied, meaning we
copy the pointer, the length, and the capacity that are on the stack. We do not
copy the data on the heap that the `String`’s pointer refers to. In other
words, it looks like figure 4-2.

<figure>
<img alt="s1 and s2 pointing to the same value" src="img/trpl04-02.svg" class="center" style="width: 50%;" />

<figcaption>

Figure 4-2: Representation in memory of the variable `s2` that has a copy of
`s1`’s pointer, length and capacity

</figcaption>
</figure>

And *not* Figure 4-3, which is what memory would look like if Rust instead
copied the heap data as well. If Rust did this, the operation `s2 = s1` could
potentially be very expensive if the data on the heap was large.

<figure>
<img alt="s1 and s2 to two places" src="img/trpl04-03.svg" class="center" style="width: 50%;" />

<figcaption>

Figure 4-3: Another possibility for what `s2 = s1` might do, if Rust chose to
copy heap data as well.

</figcaption>
</figure>

Earlier, we said that when a variable goes out of scope, Rust will
automatically call the `drop` function and clean up the heap memory for that
variable. But in figure 4-2, we see both data pointers pointing to the same
location. This is a problem: when `s2` and `s1` go out of scope, they will both
try to free the same memory. This is known as a *double free* error and is one
of the memory safety bugs we mentioned before. Freeing memory twice can lead to
memory corruption, which can potentially lead to security vulnerabilities.

In order to ensure memory safety, there’s one more detail to what happens in
this situation in Rust. Instead of trying to copy the allocated memory, Rust
says that `s1` is no longer valid and, therefore, doesn’t need to free anything
when it goes out of scope. Check out what happens when you try to use `s1`
after `s2` is created:

```rust,ignore
let s1 = String::from("hello");
let s2 = s1;

println!("{}", s1);
```

You’ll get an error like this:

```text
5:22 error: use of moved value: `s1` [E0382]
println!("{}", s1);
               ^~
5:24 note: in this expansion of println! (defined in <std macros>)
3:11 note: `s1` moved here because it has type `collections::string::String`, which is moved by default
 let s2 = s1;
     ^~
```

If you have heard the terms “shallow copy” and “deep copy” while working with
other languages, the concept of copying the pointer, length, and capacity
without copying the data probably sounds like a shallow copy. But because Rust
also invalidates the first variable, instead of calling this a shallow copy,
it’s known as a *move*. Here we would read this by saying that `s1` was *moved*
into `s2`. So what actually happens looks like Figure 4-4.

<figure>
<img alt="s1 moved to s2" src="img/trpl04-04.svg" class="center" style="width: 50%;" />

<figcaption>

Figure 4-4: Representation in memory after `s1` has been invalidated

</figcaption>
</figure>

That solves our problem! With only `s2` valid, when it goes out of scope, it
alone will free the memory, and we’re done.

Furthermore, there’s a design choice that’s implied by this: Rust will never
automatically create “deep” copies of your data. Therefore, any *automatic*
copying can be assumed to be inexpensive.

#### Ways Variables and Data Interact: Clone

If we *do* want to deeply copy the `String`’s data and not just the `String`
itself, there’s a common method for that: `clone`. We will discuss methods in
the section on [`structs` in Chapter 5][structs]<!-- ignore -->, but they’re a
common enough feature in many programming languages that you have probably seen
them before.

[structs]: ch05-01-structs.html

Here’s an example of the `clone` method in action:

```rust
let s1 = String::from("hello");
let s2 = s1.clone();

println!("s1 = {}, s2 = {}", s1, s2);
```

This will work just fine, and this is how you can explicitly get the behavior
we showed in Figure 4-3, where the heap data *does* get copied.

When you see a call to `clone`, you know that some arbitrary code is being
executed, and that code may be expensive. It’s a visual indicator that
something different is going on here.

#### Stack-only Data: Copy

There’s another wrinkle we haven’t talked about yet. This code, that we showed
earlier, works and is valid:

```rust
let x = 5;
let y = x;

println!("x = {}, y = {}", x, y);
```

This seems to contradict what we just learned: we don’t have a call to `clone`,
but `x` is still valid, and wasn’t moved into `y`.

This is because types like integers that have a known size at compile time are
stored entirely on the stack, so copies of the actual values are quick to make.
That means there’s no reason we would want to prevent `x` from being valid
after we create the variable `y`. In other words, there’s no difference between
deep and shallow copying here, so calling `clone` wouldn’t do anything
differently from the usual shallow copying and we can leave it out.

Rust has a special annotation called the `Copy` trait that we can place on
types like these (we’ll talk more about traits in Chapter 10). If a type has
the `Copy` trait, an older variable is still usable after assignment. Rust will
not let us annotate a type with the `Copy` trait if the type, or any of its
parts, has implemented the `Drop` trait. If the type needs something special
to happen when the value goes out of scope and we add the `Copy` annotation to
that type, we will get a compile-time error.

So what types are `Copy`? You can check the documentation for the given type to
be sure, but as a rule of thumb, any group of simple scalar values can be Copy,
and nothing that requires allocation or is some form of resource is `Copy`.
Here’s some of the types that are `Copy`:

* All of the integer types, like `u32`.
* The boolean type, `bool`, with values `true` and `false`.
* All of the floating point types, like `f64`.
* Tuples, but only if they contain types which are also `Copy`. `(i32, i32)` is
`Copy`, but `(i32, String)` is not.

### Ownership and Functions

The semantics for passing a value to a function are similar to assigning a
value to a variable. Passing a variable to a function will move or copy, just
like assignment. Here’s an example, with some annotations showing where
variables go into and out of scope:

<span class="filename">Filename: src/main.rs</span>

```rust
fn main() {
    let s = String::from("hello");  // s comes into scope.

    takes_ownership(s);             // s’s value moves into the function...
                                    // ... and so is no longer valid here.
    let x = 5;                      // x comes into scope.

    makes_copy(x);                  // x would move into the function,
                                    // but i32 is Copy, so it’s okay to still
                                    // use x afterward.

} // Here, x goes out of scope, then s. But since s’s value was moved, nothing
  // special happens.

fn takes_ownership(some_string: String) { // some_string comes into scope.
    println!("{}", some_string);
} // Here, some_string goes out of scope and `drop` is called. The backing
  // memory is freed.

fn makes_copy(some_integer: i32) { // some_integer comes into scope.
    println!("{}", some_integer);
} // Here, some_integer goes out of scope. Nothing special happens.
```

If we tried to use `s` after the call to `takes_ownership`, Rust would throw a
compile-time error. These static checks protect us from mistakes. Try adding
code to `main` that uses `s` and `x` to see where you can use them and where
the ownership rules prevent you from doing so.

### Return Values and Scope

Returning values can also transfer ownership. Here’s an example with similar
annotations:

<span class="filename">Filename: src/main.rs</span>

```rust
fn main() {
    let s1 = gives_ownership();         // gives_ownership moves its return
                                        // value into s1.

    let s2 = String::from("hello");     // s2 comes into scope

    let s3 = takes_and_gives_back(s2);  // s2 is moved into
                                        // takes_and_gives_back, which also
                                        // moves its return value into s3.
} // Here, s3 goes out of scope, and is dropped. s2 goes out of scope, but was
  // moved, so nothing happens. s1 goes out of scope, and is dropped.

fn gives_ownership() -> String {             // gives_ownership will move its
                                             // return value into the function
                                             // that calls it.

    let some_string = String::from("hello"); // some_string comes into scope.

    some_string                              // some_string is returned, and
                                             // moves out to the calling
                                             // function.
}

// takes_and_gives_back will both take a String and return one
fn takes_and_gives_back(a_string: String) -> String { // a_string comes into scope

    a_string  // a_string is returned, and moves out to the calling function
}
```

It’s the same pattern, every time: assigning a value to another variable moves
it, and when heap data values’ variables go out of scope, if the data hasn’t
been moved to be owned by another variable, the value will be cleaned up by
`drop`.

Taking ownership then returning ownership with every function is a bit tedious.
What if we want to let a function use a value but not take ownership? It’s
quite annoying that anything we pass in also needs to be passed back if we want
to use it again, in addition to any data resulting from the body of the
function that we might want to return as well.

It is possible to return multiple values using a tuple, like this:

<span class="filename">Filename: src/main.rs</span>

```rust
fn main() {
    let s1 = String::from("hello");

    let (s2, len) = calculate_length(s1);

    println!("The length of '{}' is {}.", s2, len);
}

fn calculate_length(s: String) -> (String, usize) {
    let length = s.len(); // len() returns the length of a String.

    (s, length)
}
```

But this is too much ceremony and a lot of work for a concept that should be
common. Luckily for us, Rust has a feature for this concept: references.
