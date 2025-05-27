using System;
using System.Globalization;
using System.Windows.Data;

namespace Sprint3.ViewModel.Converters
{
    // Xử lý chọn lại mã
    public class HideMinusOneConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is int ma && ma == -1)
                return ""; // Trả về chuỗi rỗng khi MaThanhVien == -1
            return value; // Ngược lại thì hiển thị như thường
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            // Dùng khi binding ngược (editable ComboBox), có thể giữ nguyên hoặc tùy chỉnh
            return value;
        }
    }
}
