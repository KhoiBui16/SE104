using Sprint3.ViewModel;

namespace Sprint3.Model
{
    public class ThanhVienFilterModel : BaseViewModel
    {
        // ===== ComboBox (nullable để cho phép bỏ chọn) =====
        private int? _maNgheNghiep;
        public int? MaNgheNghiep
        {
            get => _maNgheNghiep;
            set { _maNgheNghiep = value; OnPropertyChanged(); }
        }

        private int? _maQueQuan;
        public int? MaQueQuan
        {
            get => _maQueQuan;
            set { _maQueQuan = value; OnPropertyChanged(); }
        }

        private int? _maLoaiThanhTich;
        public int? MaLoaiThanhTich
        {
            get => _maLoaiThanhTich;
            set { _maLoaiThanhTich = value; OnPropertyChanged(); }
        }

        private int? _maLoaiQuanHe;
        public int? MaLoaiQuanHe
        {
            get => _maLoaiQuanHe;
            set { _maLoaiQuanHe = value; OnPropertyChanged(); }
        }

        private int? _maThanhVienCu;
        public int? MaThanhVienCu
        {
            get => _maThanhVienCu;
            set { _maThanhVienCu = value; OnPropertyChanged(); }
        }

        // ===== TextBlock hiển thị =====
        private string _tenThanhVienCu;
        public string TenThanhVienCu
        {
            get => _tenThanhVienCu;
            set { _tenThanhVienCu = value; OnPropertyChanged(); }
        }

        // ===== TextBox nhập tay =====

        // để xét thuộc tính khi nhập sai định dạng
        private bool _maThanhVienInvalid;
        public bool MaThanhVienInvalid
        {
            get => _maThanhVienInvalid;
            set { _maThanhVienInvalid = value; OnPropertyChanged(); }
        }


        private int? _maThanhVien;
        public int? MaThanhVien
        {
            get => _maThanhVien;
            set
            {
                _maThanhVien = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(MaThanhVienText)); // Cập nhật text hiển thị lại
            }
        }

        // Property trung gian dùng cho TextBox
        private string _maThanhVienText;
        public string MaThanhVienText
        {
            get => _maThanhVienText;
            set
            {
                _maThanhVienText = value;

                if (string.IsNullOrWhiteSpace(value))
                {
                    MaThanhVien = null;
                    MaThanhVienInvalid = false;
                }
                else if (int.TryParse(value, out int result))
                {
                    MaThanhVien = result;
                    MaThanhVienInvalid = false;
                }
                else
                {
                    // Sai định dạng → không cập nhật MaThanhVien
                    MaThanhVienInvalid = true; // Cảnh báo
                }
                OnPropertyChanged(nameof(MaThanhVienText));
            }
        }


        private string _gioiTinh;
        public string GioiTinh
        {
            get => _gioiTinh;
            set { _gioiTinh = value; OnPropertyChanged(); }
        }

        private string _diaChi;
        public string DiaChi
        {
            get => _diaChi;
            set { _diaChi = value; OnPropertyChanged(); }
        }

        private bool _doiInvalid;
        public bool DoiInvalid
        {
            get => _doiInvalid;
            set { _doiInvalid = value; OnPropertyChanged(); }
        }

        private int? _doi;
        public int? Doi
        {
            get => _doi;
            set
            {
                _doi = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(DoiText)); // cập nhật lại TextBox
            }
        }

        private string _doiText;
        public string DoiText
        {
            get => _doiText;
            set
            {
                _doiText = value;

                if (string.IsNullOrWhiteSpace(value))
                {
                    Doi = null;
                    DoiInvalid = false;
                }
                else if (int.TryParse(value, out int result))
                {
                    Doi = result;
                    DoiInvalid = false;
                }
                else
                {
                    DoiInvalid = true;
                }
                OnPropertyChanged(nameof(DoiText));
            }
        }


        // ===== Ngày dạng chuỗi để nhập từ TextBox =====
        private string _ngayPhatSinhTu;
        public string NgayPhatSinhTu
        {
            get => _ngayPhatSinhTu;
            set { _ngayPhatSinhTu = value; OnPropertyChanged(); }
        }

        private string _ngayPhatSinhDen;
        public string NgayPhatSinhDen
        {
            get => _ngayPhatSinhDen;
            set { _ngayPhatSinhDen = value; OnPropertyChanged(); }
        }

        private string _ngaySinhTu;
        public string NgaySinhTu
        {
            get => _ngaySinhTu;
            set { _ngaySinhTu = value; OnPropertyChanged(); }
        }

        private string _ngaySinhDen;
        public string NgaySinhDen
        {
            get => _ngaySinhDen;
            set { _ngaySinhDen = value; OnPropertyChanged(); }
        }

        private bool _ngayPhatSinhTuInvalid;
        public bool NgayPhatSinhTuInvalid
        {
            get => _ngayPhatSinhTuInvalid;
            set { _ngayPhatSinhTuInvalid = value; OnPropertyChanged(); }
        }

        private bool _ngayPhatSinhDenInvalid;
        public bool NgayPhatSinhDenInvalid
        {
            get => _ngayPhatSinhDenInvalid;
            set { _ngayPhatSinhDenInvalid = value; OnPropertyChanged(); }
        }

        private bool _ngaySinhTuInvalid;
        public bool NgaySinhTuInvalid
        {
            get => _ngaySinhTuInvalid;
            set { _ngaySinhTuInvalid = value; OnPropertyChanged(); }
        }

        private bool _ngaySinhDenInvalid;
        public bool NgaySinhDenInvalid
        {
            get => _ngaySinhDenInvalid;
            set { _ngaySinhDenInvalid = value; OnPropertyChanged(); }
        }
    }
}
