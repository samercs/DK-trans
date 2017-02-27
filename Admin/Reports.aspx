<%@ Page Title="التقارير" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="98%" align="center">
        <tr>
            <td>
                <table>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="CarReport.aspx" target="_blank">تقرير حركات رأس القاطرة</a>
            </td>
        </tr>
        
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="TrailerReport.aspx" target="_blank">تقرير حركات مقطورة</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="AllCarReport.aspx" target="_blank">تقرير حركات جميع الرؤوس القاطرة و المقطورات</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="AllCarReportByCenters.aspx" target="_blank">تقرير حركات حسب المنطقة</a>
            </td>
        </tr>
        
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="TrailerCarReport.aspx" target="_blank">تقرير ملخص حركات المقطورات مع الرؤوس</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="TrailerSumReport.aspx" target="_blank">تقرير ملخص حركات المقطورات</a>
            </td>
        </tr>
        
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="carSumReport.aspx" target="_blank">تقرير ملخص حركات الرؤوس</a>
            </td>
        </tr>
        </table>
      </td>
            <td>
                <table>
                <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="TrailerOwnerReport.aspx" target="_blank"> تقرير المالكين للمقطورات</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="CarOwnerReport.aspx" target="_blank"> تقرير المالكين لرؤوس القاطرة</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="DriversReport.aspx" target="_blank"> تقرير حركات السائق</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="AllReport.aspx" target="_blank"> تقرير ملخص الحركات</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="MonthReport.aspx" target="_blank"> كشف الحمولات الشهري</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="YearReport.aspx" target="_blank"> كشف الحمولات السنوي</a>
            </td>
        </tr>
        <tr>
            <td><img src="../Images/Ok.png" width="25" /></td>
            <td>
                <a href="MonyCollect.aspx" target="_blank"> المطالبة المالية</a>
            </td>
        </tr>
    </table>
            </td>
            <td valign="top">
                <table>
                     <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="CaponReport1.aspx" target="_blank">  تقرير الكابونات لكل السيارات</a>
                        </td>
                    </tr>
		            <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="CarCaponReport1.aspx" target="_blank">  تقرير الكابونات حسب السيارة</a>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="Capon50Report1.aspx" target="_blank">  تقرير كوبون فئة 50 لتر في فترة محددة / كل القاطرات</a>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="Capon330Report1.aspx" target="_blank">  تقرير كوبون فئة 330 لتر في فترة محددة / كل القاطرات</a>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="CaponallReport1.aspx" target="_blank">  تقرير كل الكوبونات في فترة محددة / كل القاطرات</a>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="CaponCarReport1.aspx" target="_blank">  تقرير الكوبونات حسب رقم السيارة في فترة محددة</a>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="CaponDriverReport1.aspx" target="_blank">  تقرير الكوبونات حسب اسم السائق في فترة محددة</a>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
                <table>
                     <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="TrailerSumTimeRep.aspx" target="_blank">  تقرير حركات جميع المقطورات / في يوم محدد وفترة وقت محددة</a>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="TrailerSumTimeOnwerRep.aspx" target="_blank">   تقرير حركات جميع المقطورات / في يوم محدد وفترة وقت محددة و مالك محدد</a>
                        </td>
                    </tr>
                     <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="TrailerSumDateRep.aspx" target="_blank">   تقرير حركات جميع المقطورات في فترة  محددة</a>
                        </td>
                    </tr>
                     <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="TrailerSumDateOwnerRep.aspx" target="_blank">   تقرير مقطورات المالكين في فترة  محددة</a>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="../Images/Ok.png" width="25" /></td>
                        <td>
                            <a href="CarSumDateOwnerRep.aspx" target="_blank">   تقرير قاطرات المالكين في فترة  محددة</a>
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

