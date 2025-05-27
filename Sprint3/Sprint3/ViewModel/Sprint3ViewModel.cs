using Sprint3.Model; // Cần thêm namespace chứa EF Model
using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data.Entity; // Cho EF6
using System.Linq;
using System.Windows;
using System.Windows.Input;


namespace Sprint3.ViewModel
{
    public class Sprint3ViewModel : BaseViewModel
    {

        public ICommand ThoatCommand { get; set; }
        public ICommand TraCuuThanhVienCommand { get; set; }

        // Lấy ra danh sách dữ liệu các quan hệ từ DB
        public ObservableCollection<NGHENGHIEP> DanhSachNgheNghiep { get; set; } = new ObservableCollection<NGHENGHIEP>();
        public ObservableCollection<QUEQUAN> DanhSachQueQuan { get; set; } = new ObservableCollection<QUEQUAN>();
        public ObservableCollection<LOAITHANHTICH> DanhSachLoaiThanhTich { get; set; } = new ObservableCollection<LOAITHANHTICH>();
        public ObservableCollection<LOAIQUANHE> DanhSachLoaiQuanHe { get; set; } = new ObservableCollection<LOAIQUANHE>();
        public ObservableCollection<THANHVIEN> DanhSachThanhVien { get; set; } = new ObservableCollection<THANHVIEN>();

        // Tạo danh sách dữ liệu mới để hiện thị
        public ObservableCollection<ThanhVienHienThiModel> DanhSachThanhVienHienThi { get; set; } = new ObservableCollection<ThanhVienHienThiModel>();
        public ThanhVienFilterModel ThanhVienFilter { get; set; } = new ThanhVienFilterModel();


        public Sprint3ViewModel()
        {
            ThoatCommand = new ReplyCommand<object>(CanThoat, Thoat);
            LoadComboBoxData();
            ThanhVienFilter.PropertyChanged += ThanhVienFilter_PropertyChanged; // Đăng ký sự kiện PropertyChanged cho đối tượng filter
            TraCuuThanhVienCommand = new ReplyCommand<object>(CanTraCuuThanhVien, TraCuuThanhVien);
        }

        // xử lý nút Thoát
        private bool CanThoat(object obj) => true;
        private void Thoat(object obj) => Application.Current.Shutdown();


        // Xử lý load dữ liệu lên ComboBox
        private void LoadComboBoxData()
        {
            var db = DataProvider.Ins.DB;

            // ============================ DANH SÁCH NGHỀ NGHIỆP ============================
            DanhSachNgheNghiep.Clear();
            foreach (var item in db.NGHENGHIEPs.ToList())
                DanhSachNgheNghiep.Add(item);
            DanhSachNgheNghiep.Add(new NGHENGHIEP { MaNgheNghiep = -1 }); // Cho phép bỏ chọn

            // ============================ DANH SÁCH QUÊ QUÁN ============================
            DanhSachQueQuan.Clear();
            foreach (var item in db.QUEQUANs.ToList())
                DanhSachQueQuan.Add(item);
            DanhSachQueQuan.Add(new QUEQUAN { MaQueQuan = -1 }); // Cho phép bỏ chọn

            // ============================ DANH SÁCH LOẠI THÀNH TÍCH ============================
            DanhSachLoaiThanhTich.Clear();
            foreach (var item in db.LOAITHANHTICHes.ToList())
                DanhSachLoaiThanhTich.Add(item);
            DanhSachLoaiThanhTich.Add(new LOAITHANHTICH { MaLoaiThanhTich = -1 }); // Cho phép bỏ chọn

            // ============================ DANH SÁCH LOẠI QUAN HỆ ============================
            DanhSachLoaiQuanHe.Clear();
            foreach (var item in db.LOAIQUANHEs.ToList())
                DanhSachLoaiQuanHe.Add(item);
            DanhSachLoaiQuanHe.Add(new LOAIQUANHE { MaLoaiQuanHe = -1 }); // Cho phép bỏ chọn

            // ============================ DANH SÁCH THÀNH VIÊN ============================
            DanhSachThanhVien.Clear();

            foreach (var item in db.THANHVIENs
                // === Các bảng tham chiếu cấp 1 ===
                .Include(tv => tv.NGHENGHIEP1)
                .Include(tv => tv.QUEQUAN1)
                .Include(tv => tv.THANHVIEN2)

                // === Các bảng trung gian và navigation cấp 2 ===
                .Include(tv => tv.QUANHEs.Select(q => q.LOAIQUANHE)) // Bảng trung gian: QuanHe → LoaiQuanHe
                .Include(tv => tv.THANHTICHes.Select(tt => tt.LOAITHANHTICH)) // Bảng trung gian: ThanhTich → LoaiThanhTich

                .ToList())
            {
                DanhSachThanhVien.Add(item);
            }

            // Thêm item để hỗ trợ ComboBox có thể bỏ chọn
            DanhSachThanhVien.Add(new THANHVIEN { MaThanhVien = -1 });
        }


        // Cài đặt cập nhật comboBox
        private void ThanhVienFilter_PropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            var tvF = ThanhVienFilter;

            // Khi chọn -1 → hủy chọn
            if (e.PropertyName == nameof(tvF.MaNgheNghiep) && tvF.MaNgheNghiep == -1)
                tvF.MaNgheNghiep = null;

            if (e.PropertyName == nameof(tvF.MaQueQuan) && tvF.MaQueQuan == -1)
                tvF.MaQueQuan = null;

            if (e.PropertyName == nameof(tvF.MaLoaiQuanHe) && tvF.MaLoaiQuanHe == -1)
                tvF.MaLoaiQuanHe = null;

            if (e.PropertyName == nameof(tvF.MaLoaiThanhTich) && tvF.MaLoaiThanhTich == -1)
                tvF.MaLoaiThanhTich = null;

            // TH đặc biệt khi có 2 thao tác cập nhật ==> Chia TH   
            if (e.PropertyName == nameof(tvF.MaThanhVienCu))
            {
                // Khi chọn -1 → hủy chọn 
                if (tvF.MaThanhVienCu == -1)
                {
                    tvF.MaThanhVienCu = null; // Quan trọng: reset điều kiện lọc
                    tvF.TenThanhVienCu = null;
                    return;
                }
                // Các trường hợp còn lại
                CapNhatTenThanhVienCu(); // Cập nhật lại tên thành viên cũ theo MaThanhVienCu
            }

            if (e.PropertyName == nameof(tvF.NgayPhatSinhTu) || e.PropertyName == nameof(tvF.NgayPhatSinhDen) || e.PropertyName == nameof(tvF.NgaySinhTu) || e.PropertyName == nameof(tvF.NgaySinhDen))
                ValidateDates();

            // Nếu tất cả đều null/trống thì xóa danh sách hiển thị
            if (!CanTraCuuThanhVien(null))
                DanhSachThanhVienHienThi.Clear();

        }


        // Xử lý Textblock - Tự động lấy Họ Tên từ mã thành viên cũ
        private void CapNhatTenThanhVienCu()
        {
            var tvF = ThanhVienFilter;
            if (!tvF.MaThanhVienCu.HasValue)
            {
                tvF.TenThanhVienCu = null;
                return;
            }

            int? maThanhVienCu = tvF.MaThanhVienCu;
            var thanhVien = DanhSachThanhVien.FirstOrDefault(tv => tv.MaThanhVien == maThanhVienCu);
            tvF.TenThanhVienCu = thanhVien?.HoTen; // Lấy tên thành viên cũ từ danh sách thành viên
        }

        // Hàm kiểm tra ngày nhập vào có hợp lệ hay không
        private bool TryParseKhoangNgay(string tuNgayStr, string denNgayStr, out DateTime? tuNgay, out DateTime? denNgay, out bool tuInvalid, out bool denInvalid)
        {
            tuNgay = null;
            denNgay = null;

            // Mặc định chưa có lỗi
            tuInvalid = false;
            denInvalid = false;

            // Gọi hàm kiểm tra ngày hợp lệ (CheckNgayHopLe.TryParseNgayHopLe)
            // Nếu hợp lệ → gán giá trị DateTime vào biến tương ứng
            bool isTuValid = CheckNgayHopLe.TryParseNgayHopLe(tuNgayStr, out tuNgay);
            bool isDenValid = CheckNgayHopLe.TryParseNgayHopLe(denNgayStr, out denNgay);

            // Nếu người dùng có nhập chuỗi mà sai định dạng thì bật cờ lỗi tuInvalid
            if (!string.IsNullOrWhiteSpace(tuNgayStr) && !isTuValid)
                tuInvalid = true;

            // Tương tự cho ngày kết thúc
            if (!string.IsNullOrWhiteSpace(denNgayStr) && !isDenValid)
                denInvalid = true;

            // Trả về true nếu có ít nhất một ngày hợp lệ (dù ngày còn lại có thể sai hoặc null)
            return isTuValid || isDenValid; // Trả về true nếu ít nhất một cái hợp lệ
        }

        private void ValidateDates()
        {
            var tvF = ThanhVienFilter;

            TryParseKhoangNgay(tvF.NgayPhatSinhTu, tvF.NgayPhatSinhDen, out _, out _, out bool nptInvalid, out bool npdInvalid);
            TryParseKhoangNgay(tvF.NgaySinhTu, tvF.NgaySinhDen, out _, out _, out bool nstInvalid, out bool nsdInvalid);

            tvF.NgayPhatSinhTuInvalid = nptInvalid;
            tvF.NgayPhatSinhDenInvalid = npdInvalid;
            tvF.NgaySinhTuInvalid = nstInvalid;
            tvF.NgaySinhDenInvalid = nsdInvalid;
        }


        // Xử lý chức năng tra cứu thành viên
        private bool CanTraCuuThanhVien(object obj)
        {
            var tvF = ThanhVienFilter;

            // Nếu có lỗi định dạng ngày thì không cho tra cứu
            if (tvF.NgayPhatSinhTuInvalid || tvF.NgayPhatSinhDenInvalid || tvF.NgaySinhTuInvalid || tvF.NgaySinhDenInvalid)
                return false;

            // Nếu tất cả đều null/rỗng thì không cho tra cứu
            bool allEmpty = string.IsNullOrWhiteSpace(tvF.GioiTinh) &&
                            string.IsNullOrWhiteSpace(tvF.DiaChi) &&
                            string.IsNullOrWhiteSpace(tvF.NgayPhatSinhTu) &&
                            string.IsNullOrWhiteSpace(tvF.NgayPhatSinhDen) &&
                            string.IsNullOrWhiteSpace(tvF.NgaySinhTu) &&
                            string.IsNullOrWhiteSpace(tvF.NgaySinhDen) &&
                            tvF.MaThanhVien == null &&
                            tvF.MaThanhVienCu == null &&
                            tvF.MaNgheNghiep == null &&
                            tvF.MaQueQuan == null &&
                            tvF.MaLoaiThanhTich == null &&
                            tvF.MaLoaiQuanHe == null &&
                            tvF.Doi == null;

            return !allEmpty;
        }


        /*
         Xét theo các TH như sau:
            TH 1: Chỉ xét điều kiện đối với textbox nhập vào
                - Nếu chỉ có 1 textbox nhập vào thì đúng mới cho hiển thị, ngược lại => Không cho tra cứu
                - Nếu có bao nhiêu textbox thì phải đúng bấy nhiêu textbox thì mới hiển thị, chỉ cần sai 1 textbox là return false => Không cho tra cứu
            TH 2: Chỉ xét điều kiện với comboBox chọn:
                - Mếu chỉ có 1 combox chọn thì sẽ hiển thị hết những dữ liệu có chứa comboBox đó
                - Nếu có từ 2 combox trở lên phải đúng hết thì mới cho hiển thị, chỉ cần sai 1 thuộc tính thì ko hiển thị return false => Không cho tra cứu 
            TH 3: xét cả comboBox và textBox 
                - Phải đúng hết các loại textBox, comboBox thì mới hiện, chỉ cần sai 1 thuộc tính là return false => Không cho tra cứu
         */

        private bool ThoaDieuKien(THANHVIEN tv)
        {

            var tvF = ThanhVienFilter;
            // ==== TH1 + TH3: Kiểm tra các trường nhập từ TextBox ====

            if (tvF.MaThanhVien.HasValue &&
                tv.MaThanhVien != tvF.MaThanhVien.Value)
                return false;

            if (!string.IsNullOrWhiteSpace(tvF.GioiTinh) &&
                !(tv.GioiTinh?.Contains(tvF.GioiTinh) ?? false))
                return false;

            if (!string.IsNullOrWhiteSpace(tvF.DiaChi) &&
                !(tv.DiaChi?.Contains(tvF.DiaChi) ?? false))
                return false;

            if (tvF.Doi.HasValue &&
                (!tv.Doi.HasValue || tv.Doi.Value != tvF.Doi.Value))
                return false;

            // Kiểm tra khoảng thời gian Ngày phát sinh
            /*
             - Nếu ngày phát sinh từ có giá trị và ngày phát sinh đến có ít nhất 1 giá trị
                + Nếu ngày phát sinh từ có giá trị và ngày phát sinh đến không có giá trị => Gán cho ngày phát sinh đến = ngày cuối cùng của năm (ngày phát sinh từ)
                + Nếu ngày phát sinh từ không có giá trị và ngày phát sinh đến có giá trị => Gán cho ngày phát sinh từ = ngày đầu tiên của năm (ngày phát sinh đến)
            - Nếu cả 2 có giá trị thị dùng để so sánh:
                + Ngày phát sinh từ <= Ngày phát sinh <= Ngày phát sinh đến

            ==> Làm tương tự với ngày sinh
             */

            // ==== So sánh ngày phát sinh sinh ====
            if (TryParseKhoangNgay(tvF.NgayPhatSinhTu, tvF.NgayPhatSinhDen, out DateTime? npt, out DateTime? npd, out _, out _))
            {
                if (npt.HasValue && !npd.HasValue)
                    npd = new DateTime(npt.Value.Year, 12, 31);
                else if (!npt.HasValue && npd.HasValue)
                    npt = new DateTime(npd.Value.Year, 1, 1);

                if (npt.HasValue && npd.HasValue)
                {
                    if (!tv.NgayPhatSinh.HasValue || tv.NgayPhatSinh.Value < npt || tv.NgayPhatSinh.Value > npd)
                        return false;
                }
            }

            // ==== So sánh ngày sinh ====
            if (TryParseKhoangNgay(tvF.NgaySinhTu, tvF.NgaySinhDen, out DateTime? nst, out DateTime? nsd, out _, out _))
            {
                if (nst.HasValue && !nsd.HasValue)
                    nsd = new DateTime(nst.Value.Year, 12, 31);
                else if (!nst.HasValue && nsd.HasValue)
                    nst = new DateTime(nsd.Value.Year, 1, 1);

                if (nst.HasValue && nsd.HasValue)
                {
                    if (!tv.NgaySinh.HasValue || tv.NgaySinh.Value < nst || tv.NgaySinh.Value > nsd)
                        return false;
                }
            }

            // ==== TH2: Kiểm tra các trường ComboBox chọn ====

            int comboCount = 0;
            int matchCount = 0;

            // Mã nghề nghiệp
            if (tvF.MaNgheNghiep.HasValue)
            {
                comboCount++;
                if (tv.NgheNghiep.HasValue && tv.NgheNghiep.Value == tvF.MaNgheNghiep.Value)
                    matchCount++;
            }

            // Mã quê quán
            if (tvF.MaQueQuan.HasValue)
            {
                comboCount++;
                if (tv.QueQuan == tvF.MaQueQuan.Value)
                    matchCount++;
            }

            // Mã thành viên cũ
            if (tvF.MaThanhVienCu.HasValue)
            {
                comboCount++;
                if (tv.MaThanhVienCu.HasValue && tv.MaThanhVienCu.Value == tvF.MaThanhVienCu.Value)
                    matchCount++;
            }

            // Mã loại quan hệ
            if (tvF.MaLoaiQuanHe.HasValue)
            {
                comboCount++;
                if (tv.QUANHEs.Any(q => q.MaLoaiQuanHe == tvF.MaLoaiQuanHe.Value)) // .Any xử lý các mối quan hệ 1-n
                    matchCount++;
            }

            // Mã loại thành tích
            if (tvF.MaLoaiThanhTich.HasValue)
            {
                comboCount++;
                if (tv.THANHTICHes.Any(tt => tt.MaLoaiThanhTich == tvF.MaLoaiThanhTich.Value)) // .Any xử lý các mối quan hệ 1-n
                    matchCount++;
            }

            // Kiểm tra điều kiện comboBox
            if (comboCount == 1 && matchCount == 0)
                return false;

            if (comboCount > 1 && matchCount != comboCount)
                return false;

            return true;
        }


        private void TraCuuThanhVien(object obj)
        {
            DanhSachThanhVienHienThi.Clear();
            var db = DataProvider.Ins.DB;

            // Lấy danh sách thành viên từ DB
            var thanhVienList = db.THANHVIENs.ToList();

            // Lấy ra kết quả dựa trên kết quả lọc
            var thanhVienHienThiList = DanhSachThanhVien
                .Where(ThoaDieuKien)
                .Select((tv, index) => new ThanhVienHienThiModel
                {
                    STT = (index + 1).ToString(),
                    MaThanhVien = tv.MaThanhVien.ToString(),
                    TenThanhVien = tv.HoTen ?? "",
                    MaThanhVienCu = tv.MaThanhVienCu?.ToString() ?? "",
                    TenThanhVienCu = tv.THANHVIEN2?.HoTen ?? "", // Navigation property đến thành viên cũ (theo MaThanhVienCu)
                    NgayPhatSinh = tv.NgayPhatSinh?.ToString("dd/MM/yyyy") ?? "",
                    NgaySinh = tv.NgaySinh?.ToString("dd/MM/yyyy") ?? "",
                    GioiTinh = tv.GioiTinh ?? "",
                    Doi = tv.Doi?.ToString() ?? "",
                    DiaChi = tv.DiaChi ?? "",
                    TenNgheNghiep = tv.NGHENGHIEP1?.TenNgheNghiep ?? "", // Navigation property đến tên nghề nghiệp (theo MaNgheNghiep)
                    TenQueQuan = tv.QUEQUAN1?.TenQueQuan ?? "" // Navigation property đến tên quê quán (theo MaQueQuan)
                }).ToList();


            foreach (var item in thanhVienHienThiList)
                DanhSachThanhVienHienThi.Add(item);
        }
    }
}
