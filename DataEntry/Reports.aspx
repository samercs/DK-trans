<%@ Page Title="التقارير" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="right">
        <tr>
            <td>
                <img src="../Images/Ok.png" width="25" />
            </td>
            <td align="right">
                <a href="CarReport.aspx" target="_blank">تقرير حركات رأس القاطرة</a>
            </td>
        </tr>
        <tr>
            <td>
                <img src="../Images/Ok.png" width="25" />
            </td>
            <td align="right">
                <a href="DriversReport.aspx" target="_blank">تقرير حركات السائق</a>
            </td>
        </tr>
        <tr>
            <td>
                <img src="../Images/Ok.png" width="25" />
            </td>
            <td align="right">
                <a href="TrailerReport.aspx" target="_blank">تقرير حركات مقطورة</a>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table>
                    <tr>
                        <td>
                            <img src="../Images/Ok.png" width="25" />
                        </td>
                        <td>
                            <a href="TrailerSumTimeRep.aspx" target="_blank">تقرير حركات جميع المقطورات / في يوم
                                محدد وفترة وقت محددة</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img src="../Images/Ok.png" width="25" />
                        </td>
                        <td>
                            <a href="TrailerSumTimeOnwerRep.aspx" target="_blank">تقرير حركات جميع المقطورات / في
                                يوم محدد وفترة وقت محددة و مالك محدد</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img src="../Images/Ok.png" width="25" />
                        </td>
                        <td>
                            <a href="TrailerSumDateRep.aspx" target="_blank">تقرير حركات جميع المقطورات في فترة
                                محددة</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img src="../Images/Ok.png" width="25" />
                        </td>
                        <td>
                            <a href="TrailerSumDateOwnerRep.aspx" target="_blank">تقرير مقطورات المالكين في فترة
                                محددة</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img src="../Images/Ok.png" width="25" />
                        </td>
                        <td>
                            <a href="CarSumDateOwnerRep.aspx" target="_blank">تقرير قاطرات المالكين في فترة محددة</a>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="TrailerSumDateOwnerRep2.aspx" target="_blank">   تقرير مقطورات المالكين في فترة  محددة مع الكمية</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
