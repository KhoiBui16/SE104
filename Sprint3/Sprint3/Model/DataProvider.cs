namespace Sprint3.Model
{
    public class DataProvider
    {
        // Chỉ tạo DB 1 lần
        private static DataProvider _ins;
        public static DataProvider Ins
        {
            get
            {
                if (_ins == null)
                    _ins = new DataProvider();
                return _ins;
            }
            set
            {
                _ins = value;
            }
        }

        public CayGiaPhaEntities DB { get; set; }

        private DataProvider()
        {
            DB = new CayGiaPhaEntities();
        }
    }
}
