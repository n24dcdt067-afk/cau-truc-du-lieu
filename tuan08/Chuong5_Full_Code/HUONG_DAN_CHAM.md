# Ghi chú dành cho giảng viên

## Phát đúng gói

Phát gói Sinh viên cùng đề và mẫu báo cáo. Giữ gói Full code để trình diễn hoặc đối chiếu sau khi nộp. Hai gói chỉ khác mô-đun bài làm (bốn hàm) và nhãn phiên bản; thuật toán mẫu, giao diện và bộ test giữ cùng giao diện gọi.

Không cần bắt sinh viên viết lại máy chủ HTTP hoặc trang web. Tiêu chí trọng tâm là sửa cấu trúc dữ liệu thật, kiểm thử trực tiếp hàm và giải thích kết quả.

## Điểm cần đối chiếu trong lời giải

**Đếm x.** Đặt dem = 0, p = dau; mỗi nút khớp tăng dem, sau đó dời p. Không dùng n làm kết quả vì n là tổng số nút, không phải số lần xuất hiện của x. O(n) thời gian, O(1) bộ nhớ phụ trong cách cài đặt tham khảo.

**Xoá tất cả x.** Giữ truoc và p, lưu sau trước khi cắt. Nếu p cần xoá thì sửa dau hoặc truoc.ke rồi giảm n; không dời truoc sang một nút vừa bị loại. Nếu giữ p, mới dời truoc = p. Luôn dời p = sau để tiếp tục. O(n) thời gian, O(1) bộ nhớ phụ; không tạo nút mới. Test giữ định danh của hai nút còn lại để phát hiện cách làm tạo lại danh sách.

**Lấy k phần tử.** Kiểm tra loại k và 0 <= k <= số phần tử trước vòng lặp. Bản mẫu gọi thao tác lấy k lần; dãy trả về theo đúng thứ tự lấy. O(k) thời gian cho vòng lấy, O(k) bộ nhớ cho dãy kết quả, không tính chi phí sao lưu/hiển thị của API. Kết quả không phải một đoạn đầu của mảng đáy–đỉnh.

**Xem k phần tử.** Đọc ô logic `(dau + i) % n` cho i từ 0 đến k−1; Julia cộng 1 khi truy cập Vector. Không đổi a, dau, so, n. O(k) thời gian và O(k) bộ nhớ cho kết quả. Không chấm đạt nếu lấy ra rồi thêm lại, dù dãy cuối trông giống nhau.

## Gợi ý chấm chi tiết, tổng 10 điểm

| Phần | Phân chia điểm |
|---|---|
| Bài 1: 1,0 | Đếm đúng 0,5; không sửa cấu trúc 0,25; rỗng/không có x 0,25. |
| Bài 2: 2,0 | Xoá đủ giá trị trùng 0,75; dau/n đúng 0,5; giữ các nút còn lại 0,5; một lượt duyệt 0,25. |
| Bài 3: 1,5 | Thứ tự LIFO 0,5; k sai không thay đổi 0,5; k = 0, lấy hết và rỗng 0,5. |
| Bài 4: 1,5 | FIFO khi quay vòng 0,75; giữ nguyên toàn trạng thái 0,5; kiểm tra k 0,25. |
| Kiểm thử: 2,0 | Ghi kết quả T01–T12 0,75; hai test riêng có ý nghĩa 0,75; log và lệnh chạy lại 0,5. |
| Trình diễn và giải thích: 2,0 | Giao diện gọi đúng mã đã sửa 1,0; giải thích được ba điểm trong mẫu báo cáo 1,0. |

Không đánh đồng “test đạt” với chắc chắn không còn lỗi; bộ mẫu chỉ phủ một số tình huống. Có thể hỏi sinh viên sửa x hoặc k tại chỗ và dự đoán trước kết quả. Không dùng ảnh màn hình hoặc nhãn giao diện làm bằng chứng duy nhất về người viết mã.

## Kiểm tra nhanh

Danh sách [2,2,1,2,3,2], xoá 2 -> 4 nút, còn [1,3], n = 2. Ngăn xếp [10,20,30], lấy 2 -> [30,20], còn [10]. Lấy 4 trên ngăn xếp có 3 phải báo lỗi mà không lấy bớt. Hàng đợi sau quay vòng vật lý [5,6,3,4], dau=2, so=4, xem3 -> [3,4,5], không đổi các trường.

Giữ riêng bài tập này khỏi bài kiểm tra hiểu bài trên lớp. Đây là bài làm trong 7 ngày có quyền xem mã mẫu, không phải bài thi chép lại định nghĩa. Hạn giao/nộp để trống để điền theo lịch lớp.

## Phạm vi thực thi

Python đã thử theo KET_QUA_KIEM_TRA.txt. Julia chưa được thực thi trong môi trường biên soạn; chạy instantiate và hai bộ test trên máy Julia trước buổi học. Không diễn đạt kết quả Python thành kết quả của Julia.
