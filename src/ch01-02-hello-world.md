## Hello, world

Khi đã cài Rust xong, bước tiếp theo là viết một chương trình đơn giản.
Cách truyền thống để học một ngôn ngữ mới là in ra dòng chữ "Hello, world!" ở màn hình,
trong phần này, chúng ta sẽ học theo cách truyền thống đó.


> Ghi chú: Bạn cần có chút kiến thức về command line và bạn có thể chọn bất cứ
công cụ nào để lập trình Rust.

### Tạo project

Bạn có thể không cần phải tạo project, nhưng chúng tôi đề nghị bạn nên tạo nó,
để thuận tiện cho việc quản lý code, Rust không quan tâm việc bạn đặt code ở đâu.
Mở terminal và làm theo các bước để tạo một project:

Linux và Mac:

```text
$ mkdir ~/projects
$ cd ~/projects
$ mkdir hello_world
$ cd hello_world
```

Windows:

```cmd
> mkdir %USERPROFILE%\projects
> cd %USERPROFILE%\projects
> mkdir hello_world
> cd hello_world
```

### Bắt đầu viết chương trình đầu tiên

Tạo một file mới đặt tên là *main.rs*. File Rust luôn luôn có phần đuôi là *rs*. 
Nếu bạn muốn đặt tên file với nhiều từ thì dùng `_` để tách chúng. 
Ví dụ bạn đặt tên file là *hello_world.rs* hơn là *helloworld.rs*.

Bạn mở file *main.rs* và thêm đoạn code sau:

<span class="filename">Filename: main.rs</span>

```rust
fn main() {
    println!("Hello, world!");
}
```

Lưu file và quay trở lại cửa sổ dòng lệnh. Đối với Linux và Mac, thực hiện lệnh sau :

```text
$ rustc main.rs
$ ./main
Hello, world!
```

Đối với Window, thay `./main` bằng `.\main.exe`. Không phụ thuộc vào hệ điều hành của bạn, bạn sẽ thấy
dòng chữ `Hello, world!` được hiện ra ở terminal. Nếu bạn làm được điều đó, xin chúc mừng! 
Bạn đã viết được một chương trình ở Rust rồi đấy. Điều đó đã làm cho bạn trở thành
một Rust programmer, haha.

### Cấu trúc của một chương trình Rust

Bây giờ chúng ta sẽ cùng phân tích cấu trúc của một chương trình Rust sẽ bao gồm những gì.
Hãy nhìn những dòng code dưới đây:

```rust
fn main() {

}
```

Đây là những dòng code định nghĩa một *functions* ở Rust. Hàm `main` là một hàm đặc biệt: nó là hàm
chạy đầu tiên đối với các chương trình dạng *executable*. Dòng đầu tiên chỉ ra rằng
, “Tôi khai báo một hàm tên là `main`, hàm này không nhận bất kỳ tham số nào
và không có return lại data.” Nếu có thêm tham số, thì các tham số này phải được đặt trong,
`(` và `)`.

Phần xử lý của một function phải được đặt trong cặp dấu, `{` và `}`. Để được xem như một hàm tốt về mặt trình bày
thì dấu `{` phải được đặt cùng hàng với tên hàm, và có một khoản cách giữa tên hàm và `{`.

Trong hàm `main`:

```rust
    println!("Hello, world!");
```

Với một chương trình đơn giản thì dòng code trên đã chứa đừng hết nội dùng của chương trình, cụ thể:
Nó in ra dòng text ở màn hình. Ở đây có một vài điểm lưu ý. Đầu tiên, nói về mặt coding style thì Rust dùng
`tab space` để thụt vào, không dùng `tab`.

Điều quan trọng thứ 2 là `println!`. Đây được gọi là *macro* ở Rust. Nếu gọi đây là một hàm, 
thì nó sẽ giống như vầy: `println` (không có `!`). Chúng ta sẽ quay trở lại thảo luận về *macro* ở chương 24, 
nhưng ở thời điểm hiện tại thì bạn nên hiểu là nếu bạn thấy `!` nghĩa là bạn đang gọi một *macro* hơn là một function.

Kế tiếp là `"Hello, world!"`, đây là một *string*. Chúng ta truyền chuỗi này như là một tham số cho `println!`, 
để in ra dòng text trên màn hình. Quá đơn giản!

Chúng ta sẽ kết thúc một dòng code bằng (`;`). `;` để chỉ ra rằng dòng lệnh này đã kết thúc,
dòng lệnh kế tiếp sẽ được thực thi. Hầu hết để kết thúc dòng lệnh ở Rust ta dùng `;`.

### Biên dịch và chạy chương trình

Trong phần trước chúng ta đã biết cách tạo một project đơn giản.
Kế tiếp chúng ta lần lượt tìm hiểu các bước đơn giản để biện dịch một chương trình ở Rust.

Trước khi chạy được chương trình Rust, bắt buộc ta phải biên dịch nó. Bạn có thể dùng công cụ compiler 
của Rust (`rustc`) và thực hiện dòng lệnh như dưới đây:

```text
$ rustc main.rs
```

Nếu bạn đã từng làm việc với `C` hoặc `C++` thì nó tương tự với 
`gcc` hoặc `clang`. Sau khi biên dịch thành công, Rust sẽ output ra một file binary
executable, đối với Linux hoặc Mac bạn có thể dùng câu lệnh `ls` ở shell như dòng code dưới:

```text
$ ls
main  main.rs
```

Nếu dùng Windows:

```cmd
> dir /B %= (Tuỳ chọn /B chỉ hiển thị tên file)
main.exe
main.rs
```

Cách trên sẽ hiện thị cho chúng ta thấy được 2 file: source code, có đuôi mở rộng là *.rs*, và 
chương trình thực hiện(*main.exe* đối với Windows, *main* đối với các hệ điều hành khác).
Các công việc cần làm bây giờ là chạy file *main* hoặc *main.exe*, giống như cách dưới đây:

```text
$ ./main  # hoặc .\main.exe đối với windows
```

Nếu trong file *main.rs* chương trình của bạn in ra dòng chữ là "Hello, world!", thì bạn sẽ thấy
dòng chữ `Hello, world!` ngay trên terminal của bạn.

Nếu bạn đã từng biết qua Ruby, Python, hoặc JavaScript, bạn không phải làm các bước compile cực khổ này. 
Rust là một ngôn ngữ có đặc điểm *ahead-of-time compiled*, nghĩa là bạn có thể compile một chương trình,
và đưa nó qua một môi trường khác, và bạn có thể chạy chương trình đó mà không phải phụ thuộc vào việc đã cài đặt
Rust hay chưa. Nếu bạn copy các file `.rb`, `.py`, hoặc `.js`, sang một môi trường khác, 
thì cần phải có Ruby, Python, hoặc JavaScript phải được cài đặt, 
nhưng bạn chỉ cần một dòng lệnh cho cả việc compile và chạy chương trình. 
Tất cả mọi thứ điều có một sự lựa chọn phụ hợp khi thiết kế ngôn ngữ đó.

Dùng `rustc` để compile đối với những chương trình đơn giản là một lựa chọn hợp lý, nhưng khi chương trình
phức tạp, bạn muốn quản lý các tuỳ chỉnh của chương trình và muốn công việc chia sẽ với người khác
trở nên đơn giản hơn. Phần kế tiếp chúng ta sẽ cùng tìm hiểu về một công cụ gọi là Cargo, và chúng ta sẽ dùng
tool này để viết một chương trình đơn giản `Hello, world!`.

## Xin chào, Cargo!

Cargo là một công cụ dùng để quản lý các gói và là một công cụ dùng để build các chương trình của Rust, 
và Rustaceans sử dụng Cargo để quản lý các project vì đặc điểm dể sử dụng. Ví dụ,
Cargo được dùng để build code, tự động tải về các thư viện cần thiết, và tiến hành compile các thư viện đó. 
Chúng ta gọi các thư viện phụ thuộc vào code là *dependencies*.

Chương trình đơn giản nhất ở Rust, giống như chương trình chúng ta đã xây dựng ở phần trên, không có
bất kỳ dependencies nào, cho nên, chúng ta chỉ sử dụng một phần chức năng của Cargo để xây dựng chương trình.
Nhưng khi bạn viết một chương trình phức tạp, bạn sẽ cần add thêm nhiều dependencies, và nếu bạn dùng Cargo,
điều đó thật đơn giản để thực hiện.

Phần lớn những chương trình viết bằng Rust sử dụng Cargo, nên chúng tôi mặc định bạn sẽ dùng Cargo trong suốt quá trình
còn lại. Cargo sẽ được cài mặc định trong quá trình cài Rust, nếu như bạn làm theo các bước hướng dẫn cài đặt ở phần Cài đặt. 
Nếu bạn cài đặt Rust theo một cách khác nào đó, bạn có thể kiểm tra lại Cargo đã được cài đặt hay chưa bằng dòng lệnh dưới đây:
```text
$ cargo --version
```

Nếu bạn thấy được phiên bản của Cargo, thật tuyệt vời! Nếu bạn thấy `command not
found`, kế tiếp bạn cần làm theo các bước hướng dẫn ở phần cài đặt để cài Cargo.

### Tạo project với Cargo

Bây giờ chúng ta sẽ cùng tạo một project bằng Cargo và so sánh sự khác biệt với project `hello_world` lúc trước. 
Trở lại thư mục projects (hoặc bất kỳ thư mục nào bạn muốn đặt code):

Linux và Mac:

```text
$ cd ~/projects
```

Windows:

```cmd
> cd %USERPROFILE%\projects
```

Và trên mọi hệ điều hành chạy dòng lệnh:

```text
$ cargo new hello_cargo --bin
$ cd hello_cargo
```

Chúng ta truyền thêm tham số `--bin` đối với `cargo new` bởi vì mục chúng ta muốn tạo chương trình dạng
executable, hơn là tạo một thư viện. Các file executable hay còn được gọi là *binaries*. 
Chúng ta đặt tên project là `hello_cargo`, và Cargo sẽ tạo các file trong thư mục cùng tên với tên project.

Nếu chúng ta mở thư muc *hello_cargo*, chúng ta sẽ thấy Cargo sẽ tự động tạo 2 files và một thư muc: 
file *Cargo.toml* và thư mục *src* chứa file *main.rs*. Cargo cũng sẽ khơi tạo thư mục git trong thư mục 
*hello_cargo*, cùng với file *.gitignore*; bạn có thể thay đổi phần quản lý source (source version control), 
hoặc giữ mặc định bằng cách sử dụng tuỳ chọn `--vcs`.

Mở file *Cargo.toml* bằng một công cụ chỉnh sửa text. Bạn sẽ nhìn thấy nội dụng file như dưới đây:

<span class="filename">Tên file: Cargo.toml</span>

```toml
[package]
name = "hello_cargo"
version = "0.1.0"
authors = ["Your Name <you@example.com>"]

[dependencies]
```

File này có định dạng [*TOML*][toml]<!-- ignore --> (Tom's Obvious, Minimal
Language). TOML giống như INI nhưng có thêm một số tính năng mới và được dùng
như là format của các cấu hình trong Cargo.

[toml]: https://github.com/toml-lang/toml

Dòng đầu tiên, `[package]`, là tiêu đề của các cấu hình project. Chúng ta sẽ quay trở lại kỹ hơn
nhưng phần này trong chương sau.

Những dòng kế tiếp là thông tin cấu hình của project.

Dòng cuối cùng là, `[dependencies]`, quy định các gói được dùng trong chương trình.

Nhìn file *src/main.rs*:

<span class="filename">Filename: src/main.rs</span>

```rust
fn main() {
    println!("Hello, world!");
}
```

Cargo sẽ tự động sinh ra cho ta đoạn code trên, nó giống như những dòng code chúng ta đã viết lúc trước! 
Sự khác nhau giữ project dùng Cargo và chúng ta tự khởi tạo:

- Code được đặt trong thư mục *src*.
- File *Cargo.toml* chứa tất cả các cấu hình cho project.

### Building và Running một project Cargo

Thực hiện dòng lệnh dưới đây:

```text
$ cargo build
   Compiling hello_cargo v0.1.0 (file:///projects/hello_cargo)
```

Dòng lệnh này sẽ tự động tạo cho chúng ta một file executable *target/debug/hello_cargo* (hoặc
*target\debug\hello_cargo.exe* ở Windows), bạn có thể chạy file đó ở terminal:

```text
$ ./target/debug/hello_cargo # hoặc .\target\debug\hello_cargo.exe ở Windows
Hello, world!
```

Bam! Chúng ta sẽ thấy dòng chữ `Hello, world!` ở terminal.

Chúng ta vừa build project bằng cách dùng `cargo build` và chạy nó bằng
`./target/debug/hello_cargo`, nhưng chúng ta có thể dùng dòng lệnh `cargo run` để compile và run:

```text
$ cargo run
     Running `target/debug/hello_cargo`
Hello, world!
```

Chúng ta thấy một số điểm khác biệt ở đây:

- Thay vì dùng `rustc`, build project bằng cách dùng `cargo build` ( hoặc build và run bằng `cargo run`).
-  Thay vì output kết quả cùng với thư mục hiện tại thì Cargo sẽ output ở thư mục *target/debug*.

Điểm đặc biệt là khi dùng Cargo chúng ta không phải quan tâm đến hệ điều hành đang dùng là gì.

> Chú ý: Nếu bạn muốn tìm hiểu chi tiết về cách dùng của Cargo thì tham khảo tại
[Cargo guide], chứa đầy đủ các hướng dẫn về Cargo.

[Cargo guide]: http://doc.crates.io/guide.html
