<%@ Page Title="الصفحة الرئيسية" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table width="100%">
        <tr>
            <td align="center">
                 <a class="HeaderLink" href="Default.aspx">
                 <img border="0" src="../Images/Home.png"  class="LargeIconImg" />
                 <br />
                 الرئيسية
                 </a>
            </td>
            <td align="center">
                 <a class="HeaderLink" href="CarMovment.aspx">
                 <img border="0" src="../Images/CarArival.png" class="LargeIconImg" /><br />
                 حركة الشاحنات<br />
                 (الشاحنات التي لم تصل)
                 </a>
           </td>
           <td align="center">
               <a class="HeaderLink" href="CarMovment2.aspx">
               <img border="0" src="../Images/Car.png" class="LargeIconImg" /><br />
               حركة الشاحنات
               <br />
               (جميع الشاحنات)
               </a>
         </td>
         <td align="center">
              <a class="HeaderLink" href="Reports.aspx">
              <img src="../Images/Report.png" class="LargeIconImg" /><br />
              تقارير
              </a>
        </td>
        
        </tr>
        <tr align="center">
            <td>
                                <a class="HeaderLink" href="Drivers.aspx">
                                <img src="../Images/Drivers.png" class="LargeIconImg" /><br />
                                السواقين
                                </a>
            </td>
            <td>
                                <a class="HeaderLink" href="Cars.aspx">
                                <img src="../Images/Car.png" class="LargeIconImg" /><br />
                                القاطرات
                                </a>
           </td>
           <td>
                                <a class="HeaderLink" href="Trailers.aspx">
                                <img src="../Images/CarBack.png" class="LargeIconImg" /><br />
                                المقطورات
                                </a>
           </td>
           <td>
                                <a class="HeaderLink" href="Centers.aspx">
                                <img src="../Images/Centers.png" class="LargeIconImg" /><br />
                                المحطات
                                </a>
           </td>
        </tr>
        <tr align="center">
            <td>
                                <a class="HeaderLink" href="Owners.aspx">
                                <img src="../Images/Owners.png" class="LargeIconImg" /><br />
                                اصحاب الشاحنات
                                </a>
           </td>
           <td>
                                <a class="HeaderLink" href="Users.aspx">
                                <img border="0" src="../Images/Users.png" class="LargeIconImg" /><br />
                                مستخدمين النظام
                                </a>
           </td>
           <td>
                                <a class="HeaderLink" href="ChangePassword.aspx">
                                <img border="0" src="../Images/ChangePassword.png" class="LargeIconImg" /><br />
                                تغير كلمة السر
                                </a>
           </td>
           <td>
                                <a href="LogOut.aspx" class="HeaderLink">
                                <img src="../Images/LogOut.png" class="LargeIconImg" /><br />
                                تسجيل الخروج
                                </a>
           </td>
        </tr>
    
    </table>

</asp:Content>

