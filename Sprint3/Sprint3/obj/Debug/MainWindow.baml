   M S B A M L   `   `   `  ����B  >Sprint3, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null5clr-namespace:Sprint3.ViewModelSprint3.ViewModel  5   	   K*clr-namespace:Sprint3.ViewModel.ConvertersSprint3.ViewModel.Converters  5   	       Sprint3.MainWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   1localclr-namespace:Sprint3.ViewModel     5   	   ;conv*clr-namespace:Sprint3.ViewModel.Converters     5   	     � Title$  
MainWindow��5	   	   $	��450��6   $
��1450��6)    � WindowStartupLocation$ CenterScreen=�66    � 
ResizeMode$ 	CanResize=�6[    � 	Resources 5      8   2Sprint3.ViewModel.Converters.HideMinusOneConverter   HideMinusOneConverterB   <Sprint3.ViewModel.Converters.StringNullToVisibilityConverter # StringNullToVisibilityConverter��%:   &	        &	        5   
   6%     5   
   6/   5      .��5      �  
 MainVM � DataContext# �  6   .+�5   
   ��  �� CornerRadius$ 10��6   
���   �$��1q�67   $��10q�6K   
�������._�5      ]� ��. 
�������$��5q�6@   .+�5      �� $	��Top=�6   
�������
���   �$��0,0,0,1q�5       �� Padding$
 10,5q�5      ._�5      �  � ColumnDefinitions 5      �� 5      $��* �6/   �� 5      $
��Auto �6/   .+�5!      �� $��Tra cứu thành viên��6$   $��18(�5"   $   $
��Bold"�5#   $   $��Center=�5$   $   $
��Left=�5%   $   �� 5(      $	��✕��6!   $��30��5*   !   $��30��6,   $��16(�5+   !   $
��Bold"�6/   
������ 
���   �$��0q�5-   !    � Cursor$
 Hand��65   $��1��5.   !   $	��5,2q�5/   !   $��Center=�50   !   $��Bottom=�6>   ��5)   !   �� *ThoatCommand+50   >   51      52      � 55      $��20q�6   	 � RowDefinitions	 56      �� 57      $
��Auto �6(   �� 58      $
��Auto �6(   �� 59      $
��Auto �6(   �� 5:      $��* �6(    5=      �� 5>      $��* �6+   �� 5?      $��* �6+   �� 5@      $��* �6+   �� 5A      $��* �6+   �� 5B      $��* �6+   �� 5C      $��* �6+   �� 5D      $��* �6+   �� 5E      $��* �6+   .+�5J      �� $��0��6!   $��0��6.   $��5q�6>   $	��Top=�6I   .+�5K      �� $��Mã thành viên��6      
LabelStyle#��[ 68   �� 5L      -   5        
 ��Name$
 txbMaThanhVien��5L   "     TextBoxHighlightMaThanhVien#��[ 5N   "   ��5M   "   �� *!ThanhVienFilter.MaThanhVienText+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�5N   "   5O      �� 5R      $��0��6!   $��1��6.   $��5q�6>   $	��Top=�6I   .+�5S      �� $��Mã thành viên cũ��6    #��[ 6;   �� 5T      -   5         ��Name$ cbbMaThanhVienCu��5T   #    �� SelectedValuePath$ MaThanhVien��5W   #     ComboBoxNullableStyle#��[ 5X   #   ��5U   #   �� *DanhSachThanhVien+ �� SelectedValue 5V   #   �� *ThanhVienFilter.MaThanhVienCu+$ TwoWay=�$ PropertyChanged=���5Y      �� 5Z   "   .R�5[   &   �� ��60   �� *ThanhVienFilter.MaThanhVien+ �� 	Converter# [  5\   #   5^      5a      �� 5d      $��0��6!   $��2��6.   $��5q�6>   $	��Top=�6I   .+�5e      �� $��Tên thành viên cũ��6    #��[ 6<   �� 5f      -   5         ��Name$ txblockTenThanhVienCu��5f   $     TextBlockStyle#��[ 5h   $   ��5g   $   �� * ThanhVienFilter.TenThanhVienCu+$ OneWay=�$ PropertyChanged=�5h   $   5i      �� 5l      $��0��6!   $��3��6.   $��5q�6>   $	��Top=�6I   .+�5m      �� $��Giới tính��6    #��[ 64   �� 5n      -   5        $
 txbGioiTinh��5n   "     TextBoxStyle#��[ 5p   "   ��5o   "   �� *ThanhVienFilter.GioiTinh+$ TwoWay=�$ PropertyChanged=�5p   "   5q      �� 5t      $��0��6!   $��4��6.   $��5q�6>   $	��Top=�6I   .+�5u      �� $��Địa chỉ��6    #��[ 62   �� 5v      -   5        $
 	txbDiaChi��5v   "   #��[ 5x   "   ��5w   "   �� *ThanhVienFilter.DiaChi+$ TwoWay=�$ PropertyChanged=�5x   "   5y      �� 5|      $��0��6!   $��5��6.   $��5q�6>   $	��Top=�6I   .+�5}      �� $��Đời��6    #��[ 6.   � 5~      .+�5      �� -   5        $
 txbDoi��5   &     TextBoxHighlightDoi#��[ 5�   &   ��5�   &   �� *ThanhVienFilter.DoiText+$ TwoWay=�$ PropertyChanged=�5�   &   �� 5�      $��VD: 1, 2, 3��6(   
�������$��Center=�5�   (   $��
8, 3, 0, 3q�5�   (    J� IsHitTestVisible .   K� ZIndex$ 0��5�   (   y�5�   (   �� *Text+ �� ElementName$ txbDoi��# [ 5�      5�      �� 5�      $��0��6!   $��6��6.   $��5q�6>   $	��Top=�6I   .+�5�      �� $��Tên nghề nghiệp��6    #��[ 6:   �� 5�      -   5        $ cbbMaNgheNghiep��5�   #   $ MaNgheNghiep��5�   #    �� DisplayMemberPath$ TenNgheNghiep��5�   #   #��[ 5�   #   ��5�   #   �� *DanhSachNgheNghiep+ 5�   #   �� *ThanhVienFilter.MaNgheNghiep+$ TwoWay=�5�      5�      �� 5�      $��0��6!   $��7��6.   $��5q�6>   $	��Top=�6I   .+�5�      �� $��Tên quê quán��6    #��[ 67   �� 5�      -   5        $ cbbMaQueQuan��5�   #   $ 	MaQueQuan��5�   #   $ 
TenQueQuan��5�   #   #��[ 5�   #   ��5�   #   �� *DanhSachQueQuan+ 5�   #   �� *ThanhVienFilter.MaQueQuan+$ TwoWay=�5�      5�      �� 5�      $��1��6!   $��0��6.   $��5q�6>   .+�5�      �� $��Ngày phát sinh��6    #��[ 69   ]� 5�      .+�5�      �� $
��Từ��6$   
���  ��$��0,0,5,0q�6B   $
��Left=�6S   $��Center=�6n   � 5�      .+�5�   "   �� -	   5        $
 txbTuNgayPhatSinh��5�   *    	 TextBoxHighlightNPTu#��[	 5�   *   ��5�   *   �� * ThanhVienFilter.NgayPhatSinhTu+$ TwoWay=�$ PropertyChanged=�5�   *   �� 5�   "   $��
DD/MM/YYYY��6,   
�������$��Center=�5�   ,   $��
8, 3, 0, 3q�5�   ,    .  $ 0��5�   ,   y�5�   ,   �� *Text+$ txbTuNgayPhatSinh��# [ 5�      5�      5�      �� 5�      $��1��6!   $��1��6.   $��5q�6>   .+�5�      �� $�� ��6    #��[ 6+   ]� 5�      .+�5�      �� $��Đến��6$   
���  ��$��
0, 0, 5, 0q�6C   $
��Left=�6W   $��Center=�6r   � 5�      .+�5�      �� -
   5        $
 txbDenNgayPhatSinh��5�   &    
 TextBoxHighlightNPDen#��[
 5�   &   ��5�   &   �� *!ThanhVienFilter.NgayPhatSinhDen+$ TwoWay=�$ PropertyChanged=�5�   &   �� 5�      $��
DD/MM/YYYY��6(   
�������$��Center=�5�   (   $��
8, 3, 0, 3q�5�   (    .  $ 0��5�   (   y�5�   (   �� *Text+$ txbDenNgayPhatSinh��# [ 5�      5�      5�      �� 5�      $��1��6!   $��3��6.   $��5q�6>   .+�5�      �� $��
Ngày sinh��6    #��[ 64   ]� 5�      .+�5�      �� $
��Từ��6$   
���  ��$��0,0,5,0q�6B   $
��Left=�6S   $��Center=�6n   � 5�      .+�5�   "   �� -   5        $
 txbTuNgaySinh��5�   *     TextBoxHighlightNSTu#��[ 5�   *   ��5�   *   �� *ThanhVienFilter.NgaySinhTu+$ TwoWay=�$ PropertyChanged=�5�   *   �� 5�   "   $��
DD/MM/YYYY��6,   
�������$��Center=�5�   ,   $��
8, 3, 0, 3q�5�   ,    .  $ 0��5�   ,   y�5�   ,   �� *Text+$ txbTuNgaySinh��# [ 5�      5�      5�      �� 5�      $��1��6!   $��4��6.   $��5q�6>   .+�5�      �� $�� ��6    #��[ 6+   ]� 5�      .+�5�      �� $��Đến��6$   
���  ��$��0,0,5,0q�6C   $
��Left=�6T   $��Center=�6o   � 5�      .+�5�   "   �� -   5        $
 txbDenNgaySinh��5�   *     TextBoxHighlightNSDen#��[ 5�   *   ��5�   *   �� *ThanhVienFilter.NgaySinhDen+$ TwoWay=�$ PropertyChanged=�5�   *   �� 5�   "   $��
DD/MM/YYYY��6,   
�������$��Center=�5�   ,   $��
8, 3, 0, 3q�5�   ,    .  $ 0��5�   ,   y�5�   ,   �� *Text+$ txbDenNgaySinh��# [ 5�      5�      5�      �� 5�      $��1��6!   $��6��6.   $��5q�6>   $	��Top=�6I   .+�5�      �� $��Loại thành tích��6    #��[ 6:   �� 5�      -   5        $ cbbTenLoaiThanhTich��5�   #   $ MaLoaiThanhTich��5  #   $ TenLoaiThanhTich��5  #   #��[ 5  #   ��5   #   �� *DanhSachLoaiThanhTich+ 5  #   �� *!ThanhVienFilter.MaLoaiThanhTich+$ TwoWay=�5     5     �� 5	     $��1��6!   $��7��6.   $��5q�6>   $	��Top=�6I   .+�5
     �� $��Loại quan hệ��6    #��[ 67   �� 5     -   5        $ cbbTenLoaiQuanHe��5  #   $ MaLoaiQuanHe��5  #   $ TenLoaiQuanHe��5  #   #��[ 5  #   ��5  #   �� *DanhSachLoaiQuanHe+ 5  #   �� *ThanhVienFilter.MaLoaiQuanHe+$ TwoWay=�5     5     �� 5     $��2��6!   $��3��6.   $��5q�6>   $��Center=�6I   $��Center=�6f   .+�5     �� $�� ��6    #��[ 6+   �� 5     -   5         ��Name$ btnTraCuuThanhVien��5  !   $��Tra cứu thành viên��5  !     TraCuuButtonStyle#��[ 5  !   ��5  !   �� *TraCuuThanhVienCommand+5  !   5     �� 5      $��2��6!   $��4��6.   $��5q�6>   $��Center=�6I   .+�5!     �� $�� ��6    #��[ 6+   �� 5"     -   5        $ btnThoat��5#  !   $��Thoát��5$  !     ThoatButtonStyle#��[ 5%  !   ��5"  !   �� *ThoatCommand+5%  !   5&     �� 5)     $��3��6   $��8��6*   
���   �$��1q�5+     $ 10��5,     $��10,20,10,10q�6/   $ 5q�5-     
�������._�5/     �� $
��Auto=�6'   $
��Auto=�6L   .��50     �� $��14(�51  '   
�������$��0q�53  '   $��Stretch=�54  '   ��50  '   �� *DanhSachThanhVienHienThi+ �� View 55  "   �� 56  &   .P�57  *   �� $	��STT��69    �� Width$ 60��6F    �� DisplayMemberBinding 6Q   �� *STT+�� 58  *   $��Mã thành viên��69   $	 120��6P     MaThanhVienTemplate �� CellTemplate# [ 6\   �� 59  *   $��Tên thành viên��69   $	 160��6Q     TenThanhVienTemplate# [ 6]   �� 5:  *   $��Mã thành viên cũ��69   $	 120��6S     MaThanhVienCuTemplate# [ 6_   �� 5;  *   $��Tên thành viên cũ��69   $	 160��6T     TenThanhVienCuTemplate# [ 6`   �� 5<  *   $��Ngày phát sinh��69   $	 140��6Q     NgayPhatSinhTemplate# [ 6]   �� 5=  *   $��
Ngày sinh��69   $	 140��6L     NgaySinhTemplate# [ 6X   �� 5>  *   $��Giới tính��69   $ 80��6L     GioiTinhTemplate# [ 6W   �� 5?  *   $��Đời��69   $ 60��6F     DoiTemplate# [ 6Q   �� 5@  *   $��Địa chỉ��69   $	 160��6J     DiaChiTemplate# [ 6V   �� 5A  *   $��Tên nghề nghiệp��69   $	 160��6R     TenNgheNghiepTemplate# [ 6^   �� 5B  *   $��Tên quê quán��69   $	 160��6O     TenQueQuanTemplate# [ 6[   5C  '   5E     5F     5G     5H     5I     5J     5K     5L     