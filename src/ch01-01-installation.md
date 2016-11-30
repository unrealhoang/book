## Cài đặt

Bước đầu tiên đề dùng được Rust là bạn phải cài đặt nó, yêu cầu
máy tính của bạn phải được kết nối với internet.

Tất cả các bước dưới đây đoều sử dụng terminal, các dòng lệnh điều bắt đầu bằng `$`.
Bạn không cần phải gõ lại `$`, ký hiệu này cho biết bắt đầu một dòng lệnh. `$` chạy dưới quyền
người dùng bình thường, còn `#` chạy dưới quyền quản trị cao nhất.

### Cài đặt trên hệ điều hành Linux và Mac (unix)

Khi bạn dùng Linux hoặc Mac, bạn cần mở terminal lên và gõ lệnh sau:

```text
$ curl https://sh.rustup.rs -sSf | sh
```

Dòng lệnh trên sẽ thực hiện các công việc cần thiết đề cài Rust vào máy của bạn,
trong quá trình cài bạn cần nhập mật khẩu. Nếu không có lỗi gì xảy ra thì bạn
sẽ nhận được nội dung như dưới đây:

```text
Rust is installed now. Great!
```

### Cài đặt trên Windows

Khi dùng Windows, truy cập địa chỉ [https://rustup.rs](https://rustup.rs/)<!-- ignore --> và làm theo
các hướng dẫn để tải về `rustup-init.exe`. Chạy file `rustup-init.exe` và làm theo các hướng dẫn.

Đôi với những hướng dẫn cho phiên bản Windows điều dùng `cmd` để thực hiện các thao tác dòng lệnh
. Nếu bạn dùng những loại shell khác bạn phải thực hiện các thao tác tường tự trên Mac và Linux.

### Cài đặt tuỳ chỉnh

Nếu bạn muốn tuỳ chỉnh trong quá trình cài đặt Rust thì tham khảo tại [Các tuỳ chỉnh khi cặt đặt Rust](https://www.rust-lang.org/install.html).

### Gỡ cài đặt

Việc gỡ cài đặt Rust cũng đơn giản như cài đặt vậy. Từ termial gõ:

```text
$ rustup self uninstall
```

### Xử lý khi gặp phải vấn đề

Nếu bạn đã cài Rust, thì gõ lệnh sau:

```text
$ rustc --version
```

Bạn sẽ thấy phiên bản, mã commit, và và ngày commit như là ví dụ phiên bản ví dụ dưới:

```text
rustc x.y.z (abcabcabc yyyy-mm-dd)
```

Nếu bạn nhìn thấy dòng trên, thì chúc mừng bạn đã cài đặt Rust thành công!

Bạn là người dùng Window và bạn không thấy được như trên thì kiểm tra lại Rust 
đã tồn trong biến môi trường `%PATH%` chưa.

Nếu bạn đã làm tất cả những bước trên nhưng vẫ không giải quyết được vấn đề thì dưới đây 
là một số nơi có thể giúp bạn giải quyết được vấn đề.
Vào kênh Rust ở IRC [the #rust IRC channel on irc.mozilla.org][irc]<!-- ignore -->,
thông qua [Mibbit][mibbit]. Bạn sẽ tìm các Rustaceans để giúp bạn. Một nơi tốt khác là
[Diễn đàn][users] và [Stack Overflow][stackoverflow]. Nếu ở Việt nam bạn có thể tham gia vào [Google groups][google_groups_vn]

[irc]: irc://irc.mozilla.org/#rust
[mibbit]: http://chat.mibbit.com/?server=irc.mozilla.org&channel=%23rust
[users]: https://users.rust-lang.org/
[stackoverflow]: http://stackoverflow.com/questions/tagged/rust
[google_groups_vn]: http://groups.rust-lang.vn

### Tài liệu

Khi cài đặt thì Rust sẽ mặc định sẽ sinh ra cho bạn những tài liệu cần thiết. 
Gõ `rustup doc` để xem tài liệu trên trình duyệt.

Bạn có thể tra cứu bất kỳ API nào về các thư viện chuẩn.