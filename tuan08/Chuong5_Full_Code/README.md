# Full code dành cho giảng viên

Bản này cài đặt đầy đủ cả các thuật toán mẫu và bốn hàm bài tập trong Python/Julia. Dùng để xem nguồn, trình diễn và đối chiếu; giữ riêng khi giao bài.

# Thực hành Chương 5: Python và Julia

## 1. Chọn ngôn ngữ và mở đúng thư mục

Chỉ cần chọn **Python hoặc Julia**. Hai chương trình độc lập: bản Julia không gọi Python và bản Python không cần Julia. Cả hai sử dụng cùng giao diện HTML/CSS/JavaScript, nhưng mọi thao tác cấu trúc dữ liệu chạy ở máy chủ của ngôn ngữ đã chọn.

Giải nén toàn bộ gói trước khi chạy. Thư mục đang mở phải chứa `python/`, `julia/`, `web/` và các tệp chạy. Không chạy trực tiếp từ trong cửa sổ xem ZIP. Không mở riêng `web/index.html` để chạy ứng dụng.

Mức tương thích mục tiêu: Python từ 3.10; Julia nhánh 1.x từ 1.10. Môi trường đã thực thi khi kiểm tra: Python 3.13.5 trên Linux. Chưa thực thi Julia trong môi trường biên soạn; phải kiểm tra trên máy Julia trước khi dùng làm kết quả chuẩn.

## 2. Chạy Python

Mở terminal tại thư mục gốc của gói:

```bash
python python/app.py
```

Trên Windows, có thể nhấp đúp `Chay_Python.bat`. Nếu máy có trình khởi chạy `py`, lệnh tương đương là:

```bash
py -3 python/app.py
```

Trên macOS/Linux, dùng:

```bash
python3 python/app.py
```

Python không cần cài thêm gói bằng pip. Chương trình thường tự mở trình duyệt; nếu không mở, tự nhập địa chỉ:

```text
http://127.0.0.1:8000
```

Giữ terminal mở. Dừng bằng Ctrl+C. Đổi cổng khi cổng mặc định đang bận:

```bash
python python/app.py --port 8002
```

Khi đó mở cổng 8002, không mở lại cổng 8000. Dùng `--no-browser` để không tự mở trình duyệt.

## 3. Chạy Julia

Kiểm tra Julia đã được cài và lệnh `julia --version` chạy được. Đứng tại thư mục gốc của gói, cài các phụ thuộc của giao diện:

```bash
julia --project=julia -e "using Pkg; Pkg.instantiate()"
julia --project=julia julia/app.jl
```

Mở địa chỉ được in trong terminal:

```text
http://127.0.0.1:8001
```

Có thể dùng `Chay_Julia.bat` trên Windows. Tệp chạy này thực hiện bước instantiate trước khi mở ứng dụng. Lần tải gói đầu cần Internet và có thể mất thời gian biên dịch; không đóng cửa sổ khi Julia vẫn đang xử lý.

`julia/Project.toml` cố định hai phụ thuộc trực tiếp: HTTP 1.10.19 và JSON3 1.14.3. Không cung cấp Manifest giả. Sau khi instantiate thành công, Julia có thể tạo `julia/Manifest.toml` ghi các phiên bản phụ thuộc đã giải quyết; giữ tệp này khi nộp bài để hỗ trợ chạy lại. Chưa cố định các phụ thuộc bắc cầu trước khi instantiate.

Đổi cổng:

```bash
julia --project=julia julia/app.jl 8003
```

Thuật toán và các kiểm thử dùng Base, Test, Random, không cần HTTP/JSON3. Chỉ máy chủ giao diện cần cài hai gói đó.

## 4. Kiểm thử trước và sau khi sửa mã

Chạy các lệnh sau ở **terminal khác**, hoặc dừng máy chủ rồi chạy kiểm thử. Sau khi sửa bài làm, luôn dừng và khởi động lại máy chủ; tải lại trang không tự nạp mã Python/Julia mới.

Python:

```bash
python python/test_co_ban.py
python python/test_bai_tap.py
```

Julia:

```bash
julia --project=julia julia/test_co_ban.jl
julia --project=julia julia/test_bai_tap.jl
```

`test_co_ban` kiểm tra phần mẫu và phải chạy trước khi làm bài. `test_bai_tap` kiểm tra bốn chức năng sinh viên cần viết; trong gói sinh viên, kiểm thử này chưa đạt khi các hàm còn báo chưa hoàn thành. Không sửa kỳ vọng của bộ kiểm thử để che lỗi.

Bổ sung `python/test_them.py` hoặc `julia/test_them.jl` với ít nhất hai tình huống tự chọn, rồi chạy tệp này. Ví dụ cách ghi log (dùng `>>` để nối, không ghi đè phần trước):

```bash
python python/test_co_ban.py > ket_qua_kiem_thu.txt 2>&1
python python/test_bai_tap.py >> ket_qua_kiem_thu.txt 2>&1
python python/test_them.py >> ket_qua_kiem_thu.txt 2>&1
```

Với Julia, thay ba lệnh trên bằng `julia --project=julia julia/test_....jl`. Cú pháp chuyển hướng tùy shell; cách đơn giản khác là sao chép đầu ra terminal vào tệp văn bản và giữ nguyên thông báo lỗi.

## 5. Từng bước thao tác trên giao diện

**Danh sách liên kết.** Nhập `10, 20, 30`, bấm Tạo danh sách. Nhập x = 25 và giá trị cần tìm = 20, bấm Chèn x sau nút. Danh sách phải là `10 → 20 → 25 → 30`. Đầu vào có nhiều giá trị trùng thì thao tác tìm/chèn/xoá một x dùng nút đầu tiên phù hợp. Đọc trạng thái trước và sau, không chỉ đọc thông báo thành công.

**Ngăn xếp.** Chọn Ngăn xếp, đẩy lần lượt 10, 20, 30. Bấm Xem đỉnh: nhận 30 nhưng số phần tử vẫn là 3. Bấm Lấy đỉnh: nhận 30 và số phần tử còn 2. Hình vẽ đặt đỉnh ở trên; mảng lưu từ đáy tới đỉnh.

**Hàng đợi vòng.** Tạo sức chứa 4, thêm 1, 2, 3, 4; lấy hai lần; thêm 5 và 6. Mảng vật lý là `[5, 6, 3, 4]`, `dau = 2`, `so = 4`. Dãy FIFO là `[3, 4, 5, 6]`. Khi hàng đầy, thêm tiếp bị từ chối, không ghi đè. Ô ngoài hàng vẫn có thể chứa số cũ, không được tính là phần tử hợp lệ.

**Kiểm tra dấu ngoặc.** Thử `([)]`, xem từng bước để nhận ra ngoặc đóng không khớp với đỉnh. Thử `{[(a+b)*c]}` để kiểm tra trường hợp đúng. Thuật toán chỉ kiểm tra ngoặc `()[]{}`, bỏ qua ký tự khác; không phải bộ phân tích cú pháp và không xử lý riêng dấu nháy của ngôn ngữ lập trình. Chuỗi rỗng hợp lệ.

**Bốn chức năng bài tập.** Bấm Đếm x, Xoá tất cả x, Lấy k phần tử và Xem k phần tử đầu. Các nút gọi trực tiếp hàm trong tệp bài làm. Bản sinh viên hiển thị thông báo cần hoàn thành nếu chưa viết hàm; bản đáp án có mã cho cả bốn.

**Nhật ký.** Nút Xuất nhật ký JSON ghi tối đa 200 thao tác thành công gần nhất trong tab đang mở. Các thao tác lỗi không được thêm vào nhật ký này; lưu bằng log kiểm thử hoặc ảnh nếu cần minh chứng lỗi. Tải lại/đóng tab sẽ mất nhật ký chưa xuất. Tệp JSON không thay cho kiểm thử và không chứng minh tác giả.

## 6. Đọc mã theo thứ tự nào?

| Vai trò | Python | Julia |
|---|---|---|
| Nút, danh sách, ngăn xếp, hàng đợi, ngoặc | `python/cau_truc.py` | `julia/CauTruc.jl` |
| Bốn hàm bài tập | `python/bai_lam.py` | `julia/BaiLam.jl` |
| Nhận tên thao tác, gọi hàm, chụp trước/sau | `python/dich_vu.py` | `julia/DichVu.jl` |
| Máy chủ cục bộ | `python/app.py` | `julia/app.jl` |
| Kiểm thử mẫu và bài tập | `python/test_*.py` | `julia/test_*.jl` |
| Khung giao diện | `web/index.html` | Dùng chung |
| Kiểu chữ, bố cục, trạng thái nút | `web/style.css` | Dùng chung |
| Gửi thao tác, vẽ kết quả, ghi nhật ký | `web/app.js` | Dùng chung |

Luồng gọi cụ thể khi bấm Đếm x:

```text
web/index.html: nút có data-op="list.count"
    -> web/app.js: act({op:"list.count", x:...})
    -> POST /api/action
    -> app.py hoặc app.jl
    -> dich_vu.py hoặc DichVu.jl
    -> bai_lam.dem_gia_tri(L, x) hoặc BaiLam.dem_gia_tri(L, x)
    -> kết quả JSON -> cập nhật trạng thái và giải thích trên trang
```

`/api/state` đọc trạng thái và mã phiên cục bộ. `/api/action` nhận lệnh. Không sửa JavaScript để tính câu trả lời thay cho hàm; việc đó không kiểm tra được cài đặt bằng Julia/Python của sinh viên.

## 7. Các điểm dễ nhầm

`gt` là dữ liệu; `ke` giữ tham chiếu tới nút kế tiếp. `p = p.ke` chỉ dời biến p; `p.ke = ...` sửa đường nối của một nút. Python dùng `None`, Julia dùng `nothing` và các phép kiểm tra `===`/`!==` phù hợp trong mã mẫu.

Với danh sách, `L.n` là số nút. Với hàng đợi, `q.n` là sức chứa và `q.so` mới là số phần tử hợp lệ. Không dùng số ô đang chứa số khác rỗng để suy ra độ dài hàng đợi.

Trong hàng đợi, `dau` là chỉ số logic bắt đầu từ 0 ở cả hai bản. Python đọc ô logic i bằng `q.a[i]`, Julia bằng `q.a[i + 1]`. Dấu `!` trong tên hàm Julia biểu thị quy ước hàm có thay đổi dữ liệu; các tên ở bộ mã phải giữ nguyên để máy chủ gọi được.

Các hàm bài tập phải xử lý đúng `k = 0`, rỗng, giá trị trùng và k sai. `bool`/`Bool` không được coi là số lượng hợp lệ dù có quan hệ kiểu với số nguyên trong hai ngôn ngữ.

## 8. Phạm vi, lỗi cài đặt và giới hạn

Ứng dụng chỉ dành cho một người học trên máy cá nhân, lắng nghe ở `127.0.0.1`, không đưa lên Internet. Các tab nối cùng máy chủ dùng chung cấu trúc dữ liệu. Trạng thái nằm trong RAM, không có cơ sở dữ liệu; dừng máy chủ sẽ mất trạng thái. Bấm Đọc lại trạng thái để đồng bộ sau khi thao tác ở tab khác.

Máy chủ chỉ phục vụ ba tệp giao diện đã liệt kê; kiểm tra Host, Origin và token cho yêu cầu thay đổi dữ liệu. Đây vẫn là ứng dụng thực hành, không phải một dịch vụ đã được kiểm toán bảo mật hay hệ thống nhiều người dùng.

Giới hạn của giao diện: tối đa 50 nút danh sách, 50 phần tử ngăn xếp, sức chứa hàng đợi 1–12, số nguyên trong ±1.000.000, chuỗi ngoặc 200 ký tự. Đây là quy ước bổ sung để dễ quan sát và kiểm tra đầu vào, không phải giới hạn toán học của cấu trúc dữ liệu.

Trạng thái hiển thị là bản sao tạo bằng cách duyệt. Hoạt ảnh và tốc độ giao diện không phải phép đo độ phức tạp. Một thao tác nối/lấy ở lõi có thể O(1), nhưng sao lưu, chuyển JSON và vẽ n phần tử có thêm chi phí O(n).

Nếu `python` hoặc `julia` không được nhận diện, kiểm tra cài đặt và PATH; mở lại terminal sau khi cài. Nếu thiếu thư mục web, giải nén lại toàn bộ gói. Nếu Julia báo thiếu HTTP/JSON3, chạy lại lệnh instantiate đúng `--project=julia` khi có mạng. Nếu đang bận cổng, đổi cổng hoặc dừng tiến trình cũ bằng Ctrl+C; không đổi địa chỉ lắng nghe thành 0.0.0.0 để xử lý lỗi cổng.

Nếu thông báo tiếng Việt không hiện đúng trong Windows CMD, chạy `chcp 65001`, hoặc dùng tệp `.bat` đã có lệnh này. Lưu các tệp mã bằng UTF-8. Không sửa tên module hoặc đổi chữ hoa/thường của tệp Julia.

Nếu viết sai liên kết làm vòng lặp chạy mãi, dừng bằng Ctrl+C, sửa hàm và chạy kiểm thử trước khi mở lại giao diện. Cơ chế sao lưu phục hồi khi có ngoại lệ không phải cơ chế dừng mọi vòng lặp vô hạn.

## 9. Kiểm chứng của bản phân phối

Python 3.13.5/Linux: 42 kiểm thử của bản đáp án đạt (25 kiểm thử cơ bản và 17 kiểm thử bài tập). Có kiểm tra chuỗi 1.000 thao tác danh sách, 1.000 thao tác hàng đợi và 200 dãy đối chiếu cho bài tập với seed 20260917; đây là các vòng lặp bên trong test, không phải 42 + 2.200 test độc lập. Bộ cơ bản của bản sinh viên đạt 25 test.

Đã kiểm tra HTTP Python cho tệp giao diện, dữ liệu JSON, dữ liệu sai, kiểm tra Host/Origin/token và trạng thái không đổi khi từ chối yêu cầu. Đã kiểm tra giao diện với Chromium bằng dựng DOM và cầu nối tới API cục bộ thật, gồm bốn chức năng, trạng thái quay vòng, dấu ngoặc, chuyển thẻ và bố cục rộng 390 px. Do môi trường trình duyệt có hạn chế điều hướng, đây không phải kiểm tra toàn bộ đường tải trang HTTP trong trình duyệt trên máy người dùng. Chưa kiểm thử thao tác lưu tệp tải xuống qua hộp thoại của hệ điều hành.

Julia: đã cung cấp đầy đủ nguồn và test riêng, đối chiếu cú pháp/API với tài liệu chính thức; **chưa thực thi vì môi trường biên soạn không có Julia**. Không có kết quả Julia giả định, không có cam kết đã thử trên Windows/macOS hoặc mọi phiên bản. Chạy test trên máy trước khi so sánh và nộp log thực tế.

## 10. Cơ sở nội dung và tài liệu kỹ thuật

Nguồn bài học: `05-Danh-sach-lien-ket-Ngan-xep-Hang-doi.pdf`, Chương 5, mục 5.3–5.5; Bài 5.1 ở trang PDF 15; Bài 5.2 ở trang PDF 25. Giữ các tên gt, ke, dau, n, so và các quy tắc thao tác trong chương. Đề 7 ngày rút gọn khối lượng, chỉ yêu cầu một ngôn ngữ. Giao diện, API, giới hạn đầu vào, bốn hàm mở rộng và các kiểm thử là phần biên soạn bổ sung, không phải nguyên văn bài trong PDF.

Tài liệu chính thức về máy chủ, gói và môi trường:

```text
https://docs.python.org/3/library/http.server.html
https://github.com/JuliaWeb/HTTP.jl/blob/v1.10.19/docs/src/server.md
https://quinnj.github.io/JSON3.jl/stable/
https://pkgdocs.julialang.org/v1/environments/
```

Python lưu ý http.server chỉ có kiểm tra bảo mật cơ bản và không được khuyến nghị cho production. Bộ mã này cố ý chỉ phục vụ học tập cục bộ.
