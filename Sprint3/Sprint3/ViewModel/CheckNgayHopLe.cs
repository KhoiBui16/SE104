using System;

namespace Sprint3.ViewModel
{
    public class CheckNgayHopLe
    {
        // Hàm kiểm tra chuỗi ngày dạng dd/MM/yyyy có hợp lệ hay không
        public static bool TryParseNgayHopLe(string input, out DateTime? date)
        {
            date = null; // Khởi tạo ngày trả ra là null

            // Bước 1: Nếu chuỗi rỗng hoặc null thì không hợp lệ
            if (string.IsNullOrWhiteSpace(input))
                return false;

            // Bước 2: Tách chuỗi ngày theo dấu '/'
            var parts = input.Split('/');
            if (parts.Length != 3)
                return false; // Không phải định dạng 3 phần (ngày/tháng/năm)

            // Bước 3: Chuyển đổi từng phần sang số nguyên
            if (!int.TryParse(parts[0], out int day) ||     // ngày
                !int.TryParse(parts[1], out int month) ||    // tháng
                !int.TryParse(parts[2], out int year))       // năm
                return false;

            // Bước 4: Kiểm tra tháng hợp lệ (1–12)
            if (month < 1 || month > 12)
                return false;

            // Bước 5: Tạo mảng số ngày tương ứng của từng tháng
            // Đặc biệt: Tháng 2 có thể là 28 hoặc 29 ngày tùy năm nhuận
            // Năm nhuận: (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
            int[] daysInMonth = {
                31,                                            // Tháng 1
                DateTime.IsLeapYear(year) ? 29 : 28,           // Tháng 2 (năm nhuận = 29, thường = 28)
                31, 30, 31, 30, 31, 31, 30, 31, 30, 31          // Tháng 3 → 12
            };

            // Bước 6: Kiểm tra ngày nằm trong khoảng hợp lệ của tháng đã nhập
            if (day < 1 || day > daysInMonth[month - 1])
                return false;

            try
            {
                // Bước 7: Nếu hợp lệ thì tạo đối tượng DateTime
                date = new DateTime(year, month, day);
                return true;
            }
            catch
            {
                // Bắt lỗi nếu tạo ngày thất bại (phòng ngừa lỗi bất ngờ)
                return false;
            }
        }
    }
}
