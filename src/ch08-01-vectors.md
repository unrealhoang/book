## Vectors

Kiểu dữ liệu đầu tiên mà chúng ta tìm hiểu là `Vec<T>`, còn gọi là *vector*. Vector
sẽ cho phép chúng ta lưu trữ nhiều hơn một giá trị trong một cấu trúc dữ liệu bằng cách
xếp tất cả các giá trị nằm liền kề nhau trong bộ nhớ. Vector chỉ có thể lưu trữ dữ liệu
của cùng 1 kiểu. Nó rất hữu dụng trong tình huống bạn có một loạt các phần tử, chẳng hạn
như các dòng chuỗi (line of string) trong một file, hoặc giá của từng món hàng trong một cái
giỏ hàng.

### Tạo mới một Vector

Để tạo mới một vector rỗng, chúng ta có thể gọi hàm `Vec::new`:

```rust
let v: Vec<i32> = Vec::new();
```

Lưu ý rằng chúng ta để chỉ định kiểu (type annotation) ở đây. Bởi vì chúng ta không
nhét (insert) gì vào vector này, Rust không biết kiểu phần tử mà chúng ta dự định
lưu là gì. Đây là một điểm quan trọng. Vector là đồng nhất: chúng có thể lưu trữ
nhiều giá trị, nhưng những giá trị đó phải là cùng 1 kiểu dữ liệu. Vector được
cài đặt (implemented) sử dụng Generics, sẽ được tìm hiểu sau ở chương 10 để dùng
cho kiểu dữ liệu của chính chúng ta. Bây giờ, tất cả những gì bạn cần biết là kiểu
`Vec` được cung cấp bởi thư viện chuẩn (standard library) có thể giữ được bất kì kiểu
dữ liệu nào, và khi muốn chỉ định kiểu dữ liệu cho `Vec` thì chúng ta đưa kiểu dữ liệu
của nó vào bên trong ngoặc `<>`. Trong ví dụ trên, chúng ta đã báo với Rust là `Vec`
`v` sẽ giữ những phần tử thuộc kiểu `i32`.

Trong code thực tế, Rust có thể suy luận ra kiểu dữ liệu chúng ta muốn lưu trữ
một khi chúng ta `insert` giá trị vào, nên rất hiếm khi bạn phải chỉ định kiểu.
Trong code cũng thường có những lúc chúng ta muốn khởi tạo những giá trị ban đầu
cho `Vec`, Rust cung cấp cho chúng ta macro `vec!` để làm chuyện này một cách tiện
lợi hơn. Macro này sẽ tạo một `Vec` mới và đưa vào những giá trị mà chúng ta cũng
cấp cho nó. Ví dụ sau đây sẽ tạo mới một `Vec<i32>` mà giữ những phần tử `1`, `2`,
và `3`:

```rust
let v = vec![1, 2, 3];
```

Vì chúng ta đưa vào những giá trị `i32` ban đầu, Rust có thể suy luận ra kiểu
dữ liệu của `v` là `Vec<ì>`, và chỉ định kiểu là không cần thiết. Tiếp theo hãy
cùng xem cách để thay đổi 1 vector.

### Thay đổi một Vector

Để tạo ra một vector và thêm phần tử vào nó, chúng ta có thể dùng hàm `push`:

```rust
let mut v = Vec::new();

v.push(5);
v.push(6);
v.push(7);
v.push(8);
```

Giống như bất kì biến nào mà chúng ta đã thảo luận trong Chương 3, nếu chúng ta muốn
thay đổi giá trị của chúng, chúng ta phải khai báo nó thay đổi được bằng từ khoá
`mut`. Những số chúng ta cho vào đều là `i32`, và Rust suy luận được điều này từ data,
nên chúng ta không cần phải khai báo kiểu `Vec<i32>`.

### Giải phóng một Vector sẽ giải phóng những phần tử của nó

Giống như bất kì `struct` nào khác, vector sẽ được giải phóng khi nó ra khỏi phạm vi:

```rust
{
    let v = vec![1, 2, 3, 4];

    // làm gì đó với v

} // <- v ra khỏi phạm vi và bị giải phóng ở đây.
```

Khi vector bị giải phóng, tất cả nội dung của nó cũng sẽ bị giải phóng, có nghĩa
những số nguyên nó lưu giữ cũng bị dọn dẹp. Bạn thấy có vẻ rất dễ hiểu ở đây,
nhưng nó có thể trở nên phức tạp hơn một chút khi chúng ta bắt đầu cho tham chiếu
vào thành phần tử của vector. Hãy cùng giải quyết vấn đề đó tiếp theo!

### Đọc phần tử của Vector

Bây giờ bạn đã biết cách để khởi tạo, thay đổi, và giải phóng vector, bước tiếp
theo sẽ là biết cách để đọc nội dung của nó. Có 2 cách để tham chiếu một giá trị
được lưu trữ trong vector. Trong những ví dụ, chúng ta sẽ khai báo kiểu dữ liệu
của các giá trị được trả về từ các hàm để dễ đọc hơn.

Ví dụ sau đây sử dụng cả 2 cách để truy cập dữ liệu trong 1 vector là dùng cú pháp
chỉ mục hoặc dùng hàm `get`:

```rust
let v = vec![1, 2, 3, 4, 5];

let third: &i32 = &v[2];
let third: Option<&i32> = v.get(2);
```

Có vài điều cần lưu ý ở đây. Đầu tiên, chúng ta sử dụng giá trị chỉ mục `2` để
lấy ra phần tử thứ 3: Vector được đánh chỉ mục bằng số, bắt đầu bằng 0.
Thứ 2, hai cách khác nhau để lấy phần tử thứ 3 là: sử dụng `&` và `[]` sẽ trả về
cho chúng ta một tham chiếu, hoặc sử dụng hàm `get` với chỉ mục được truyền vào
tham số sẽ trả về cho chúng ta kiểu `Option<&T>`.

Lý do Rust có 2 cách để tham chiếu 1 phần tử là để bạn có thể cách mà chương trình
hoạt động khi bạn thử sử dụng 1 giá trị chỉ mục mà Vector không có phần tử tại đó.
Để ví dụ, chương trình sẽ làm gì nếu nó có 1 vector giữ 5 phần tử và thử truy xuất
phần tử tại chỉ mục 100 như sau:

```rust,should_panic
let v = vec![1, 2, 3, 4, 5];

let does_not_exist = &v[100];
let does_not_exist = v.get(100);
```

Khi bạn chạy chương trình này, bạn sẽ thấy là với hàm `[]` đầu tiên, Rust sẽ
bị `panic!` khi phần tử không tồn tại được truy xuất. Hàm này nên được dùng
nếu bạn muốn chương trình của mình xem việc truy xuất phần tử sau phần tử cuối
cùng của vector là nguy hiểm và cần phải crash chương trình ngay lập tức.

Khi hàm `get` được truyền vào chỉ mục nằm ngoài mảng, nó sẽ trả về `None` và
không bị `panic!`. Bạn nên xài nó nếu việc truy cập phần tử ngoài mảng là thường
xuyên xảy ra trong trường hợp bình thường. Code của bạn phải có logic để xử lý
hoặc có `Some(&element)` hoặc `None`, như chúng ta đã thảo luận trong Chương 6.
Ví dụ, chỉ mục có thể đến từ người dùng nhập vào 1 số. Nếu họ lỡ nhập nhầm 1 số
quá lớn vào chương trình của bạn trả ra `None`, bạn có thể báo với người dùng có
bao nhiêu phần tử đang ở trong mảng và cho họ cơ hội khác để nhập vào giá trị
đúng. Việc đó sẽ thân thiện với người dùng hơn là chương trình crash ngay mỗi khi
nhập nhầm 1 số nào đó!

#### Tham chiếu không hợp lệ

Một khi chương trình có tham chiếu hợp lệ, borrow checker sẽ thi hành những luật
ownership và borrowing đã được thảo luận trong Chương 4 để đảm bảo tham chiếu này
và bất kì những tham chiếu nào khác đến nội dụng của vector đều ở trang thái hợp lệ.
Nhắc lại luật nói rằng chúng ta không thể có tham chiếu thay đổi và tham chiếu chỉ đọc
trong cùng 1 phạm vi (scope). Luật đó cũng áp dụng trong ví dụ sau đây, khi chúng ta
giữ một tham chiếu chỉ đọc tới phần tử đầu tiên trong mảng và thử cho thêm phần tử vào
cuối mảng:

```rust,ignore
let mut v = vec![1, 2, 3, 4, 5];

let first = &v[0];

v.push(6);
```

Biên dịch chương trình này sẽ đưa ra lỗi sau:

```text
error[E0502]: cannot borrow `v` as mutable because it is also borrowed as immutable
  |
4 | let first = &v[0];
  |              - immutable borrow occurs here
                 - mượn tham chiếu chỉ đọc ở đây
5 |
6 | v.push(6);
  | ^ mutable borrow occurs here
      mượn tham chiếu thay đổi ở đây
7 | }
  | - immutable borrow ends here
      tham chiếu chỉ đọc kết thúc ở đây
```

Đoạn code trên nhìn có vẻ nó nên hoạt động được: tại sao tham chiếu tới phần tử
đầu tiên lại quan tâm tới thay đổi ở cuối của mảng? Lý do code này không hoạt động
là vì cách vector hoạt động. Thêm phần tử mới vào cuối vector có thể cần phải
cấp phát 1 phần bộ nhớ mới và copy những phần tử cũ lên vùng nhớ mới, trong trường
hợp khi đã không còn đủ bộ nhớ để nhét tất cả các phần tử liền kề nhau nữa. Trong
trường hợp đó, tham chiếu tới phần tử đầu tiên có thể là chỉ tới 1 vùng nhớ đã bị
giải phóng. Luật mượn tham chiếu đã ngăn cản chương trình không bị rơi vào trường
hợp đó.

> Ghi chú: Để biết thêm thông tin về vấn đề này, hãy xem [The Nomicon][nomicon].
[nomicon]: https://doc.rust-lang.org/stable/nomicon/vec.html

### Sử dụng Enum để Lưu nhiều kiểu dữ liệu

Vào đầu chương này, chúng ta đã nghiên cứu là vector chỉ có thể lưu trữ giá trị
mà có cùng một kiểu dữ liệu. Điều này có thể gây khó chịu, chắc chắn sẽ có những
trường hợp cần lưu 1 mảng các thứ có kiểu khác nhau. May mắn thay, các kiểu con
của enum đều được định nghĩa dưới cùng 1 kiểu enum. Khi chung ta cần lưu trữ phần
tử với những kiểu dữ liệu khác nhau, chúng ta có thể định nghĩa và sử dụng enum!

Ví dụ, cho rằng chúng ta muốn lấy giá trị trong 1 dòng của bảng tính, nơi mà
1 số cột chứa số nguyên, 1 số chứa số thực, và 1 số chứa chuỗi. Chúng ta có thể
định nghĩa tất cả biến thể của enum và giữ các kiểu giá trị khác nhau, khi đó tất cả
biến thể của enum đều được xem là cùng 1 kiểu. Như vậy chúng ta có thể tạo ra một
vector giữ những enum đó và, cuối cùng, giữ các kiểu dữ liệu khác nhau:

```rust
enum SpreadsheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}

let row = vec![
    SpreadsheetCell::Int(3),
    SpreadsheetCell::Text(String::from("blue")),
    SpreadsheetCell::Float(10.12),
];
```

Lý do mà Rust cần biết chính xác kiểu dữ liệu nào sẽ được chứa trong vector tại
thời điểm biên dịch (compile time) là vì nó cần biết chính xác bao nhiêu không gian
trong bộ nhớ Heap cần để chứa mỗi phần tử. Lợi điểm thứ 2 của việc này là chúng ta
có thể giới hạn những kiểu dữ liệu được chứa trong vector. Nếu Rust cho phép vector
có thể giữ bất kì kiểu dữ liệu nào, sẽ có khả năng một hay nhiều kiểu dữ liệu sẽ
gây ra lỗi khi chúng ta thực thi các hàm không tương thích. Sử dụng kết hợp enum và
`match` có nghĩa là Rust có thể đảm bảo ở compile time là chúng ta luôn luôn xử lý
tất cả trường hợp có thể xảy ra, như chúng ta đã thảo luận ở Chương 6.

<!-- Can you briefly explain what the match is doing here, as a recap? How does
it mean we always handle every possible case? I'm not sure it's totally clear.
-->
<!-- Because this is a focus of chapter 6 rather than this chapter's focus, we
don't think we should repeat it here as well, but we added a reference. /Carol
-->

Nếu tại thời điểm viết chương trình bạn không biết tất cả những kiểu dữ liệu có thể
sẽ được chứa trong vector lúc nó được chạy, kĩ thuật dùng enum sẽ không hoạt động.
Thay vào đó, bạn có thể sử dụng trait object, chúng ta sẽ tìm hiểu về nó trong
Chương 13.

Sau khi chúng ta đã tìm hiểu qua một số những cách thông dụng nhất để sử dụng vector,
hãy đảm bảo là bạn sẽ xem qua tài liệu API (API documentation) để biết tất cả những
hàm hữu ích được viết trong module `Vec` của thư viện chuẩn. Ví dụ, ngoài `push` còn
có hàm `pop` sẽ giúp bạn xoá và lấy ra phần tử cuối cùng trong vector. Bây giờ, hãy
cùng qua tới kiểu dữ liệu tập hợp tiếp theo: `String`!

Now that we've gone over some of the most common ways to use vectors, be sure
to take a look at the API documentation for all of the many useful methods
defined on `Vec` by the standard library. For example, in addition to `push`
there's a `pop` method that will remove and return the last element. Let's move
on to the next collection type: `String`!

<!-- Do you mean the Rust online documentation here? Are you not including it
in the book for space reasons? We might want to justify sending them out of the
book if we don't want to cover it here -->

<!-- Yes, there are many, many methods on Vec: https://doc.rust-lang.org/stable/std/vec/struct.Vec.html
Also there are occcasionally new methods available with new versions of the
language, so there's no way we can be comprehensive here. We want the reader to
use the API documentation in these situations since the purpose of the online
docs is to be comprehensive and up to date. I personally wouldn't expect a book
like this to duplicate the info that's in the API docs, so I don't think a
justification is necessary here. /Carol  -->
