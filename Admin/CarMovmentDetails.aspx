<%@ Page Title="تقرير تحركات المركبات" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

<script runat="server">

    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ParameterID"] == null)
        {
            Message msg = new Message("لا يمكن الدخول الى هذة الصفحة في الوقت الحالي", false, "Default.aspx", "Default.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
        {
            Label l = (Label)e.Item.FindControl("Label1");
            l.Text = DataBase.GetPName("Centers", "Name", "id", l.Text);
            l = (Label)e.Item.FindControl("Label2");
            l.Text = DataBase.GetPName("Centers", "Name", "id", l.Text);
            l = (Label)e.Item.FindControl("Label3");
            l.Text = DataBase.GetPName("Users", "Name", "id", l.Text);
            l = (Label)e.Item.FindControl("Label4");
            l.Text = DataBase.GetPName("Users", "Name", "id", l.Text);
            l = (Label)e.Item.FindControl("Label5");
            l.Text = DataBase.GetPName("Users", "Name", "id", l.Text);
            l = (Label)e.Item.FindControl("Label6");
            l.Text = DataBase.GetPName("Users", "Name", "id", l.Text);

        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table width="100%" class="DataEnterTable" align="center">
        <tr align="center" class="Title2">
            <td align="center">
                حركة المركبات
            </td>
        </tr>
        <tr>
            <td>
            
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT Transports.*, Cars.Number as Car_Number, Drivers.Name As Driver_Name, Trailer.Number AS Trailer_Number FROM Cars INNER JOIN Drivers INNER JOIN Transports ON Drivers.id = Transports.DriverId INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Cars.id = Transports.CarID where (transports.id=@id)">
                        <SelectParameters>
                            <asp:SessionParameter DbType="Int64" SessionField="ParameterID" Name="id" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                
                
                <asp:DataList ID="DataList1" runat="server" 
                    DataSourceID="SqlDataSource1" OnItemDataBound="DataList1_ItemDataBound" 
                    Width="100%">
                    <ItemTemplate>
                        <table width="100%" align="center">
                            <tr class="Title">
                                <td colspan="2">معلومات الرحلة رقم <%#Eval("id") %></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td class="Title2" colspan="2">
                                    معلومات المكان
                                </td>
                            </tr>
                            <tr class="tr2">
                                <td>الانطلاق من </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("fromid") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr class="tr2">
                                <td>التفريغ في </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("toid") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td class="Title2" colspan="2">
                                    معلومات السائق
                                </td>
                            </tr>
                            <tr class="tr2">
                                <td>اسم السائق</td>
                                <td>
                                    <%#Eval("Driver_Name") %>
                                </td>
                            </tr>
                            
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td class="Title2" colspan="2">
                                    معلومات المركبة
                                </td>
                            </tr>
                            <tr class="tr2">
                                <td>رقم القاطرة</td>
                                <td>
                                    <%#Eval("Car_Number") %>
                                </td>
                            </tr>
                            <tr class="tr2">
                                <td>رقم المقطورة</td>
                                <td>
                                    <%#Eval("Trailer_Number") %>
                                </td>
                            </tr>
                            
                            
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td class="Title2" colspan="2">
                                    معلومات الحمولة
                                </td>
                            </tr>
                            <tr class="tr2">
                                <td>كمية الحمولة بالطن</td>
                                <td>
                                    <%#Eval("Tonnage") %>
                                </td>
                            </tr>
                            
                            
                            <tr>
                                <td colspan="2">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td class="Title2" colspan="2">
                                    مواعيد الرحلة
                                </td>
                            </tr>
                            <tr>
                                <td class="tr2" colspan="2">
                                    
                                    <table width="100%">
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td  class="tr1">ادخل بواسط</td>
                                            <td  class="tr1">الساعة</td>
                                        </tr>
                                        
                                        <tr class="tr2">
                                            <td>انطلقت الساعة</td>
                                            <td>
                                                <%#Eval("leavingtime1","{0:t}") %>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("EnterUserId1") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <%#Eval("EnterTime1","{0:t}") %>
                                            </td>
                                        </tr>
                                        <tr class="tr2">
                                            <td>وصلت مكان التفريغ الساعة</td>
                                            <td>
                                                <%#Eval("arrivaltime1","{0:t}") %>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text='<%#Eval("UpdateUserId1") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <%#Eval("UpdateTime1","{0:t}") %>
                                            </td>
                                        </tr>
                                        <tr class="tr2">
                                            <td>انهت التحميل و انطلقت الساعة</td>
                                            <td>
                                                <%#Eval("leavingtime2","{0:t}") %>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text='<%#Eval("EnterUserId2") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <%#Eval("EnterTime2","{0:t}") %>
                                            </td>
                                        </tr>
                                        <tr class="tr2">
                                            <td>انهت رحلتها الساعة</td>
                                            <td>
                                                <%#Eval("arrivaltime2","{0:t}") %>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text='<%#Eval("UpdateUserId2") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <%#Eval("UpdateTime2","{0:t}") %>
                                            </td>
                                        </tr>
                            
                                    </table>
                                    
                                    
                                </td>
                            </tr>
                            
                            
                            
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                
             </td>
        </tr>
    </table>
    
</asp:Content>

