<%@ Page Title="تقارير" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int CurentYear = DateTime.Now.Year;
            for (int i = 1; i <= 31; i++)
            {
                if (i <= 12)
                {
                    DropDownList2.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
                DropDownList1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                
            }
            for (int i = 2010; i <= CurentYear + 1; i++)
            {
                DropDownList3.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            if (DropDownList1.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                DropDownList1.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (DropDownList2.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                DropDownList2.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }

            if (DropDownList3.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                DropDownList3.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
            
            
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("Label1");
            l.Text = DataBase.GetPName("Centers", "Name", "id", l.Text);
            l = (Label)e.Row.FindControl("Label2");
            l.Text = DataBase.GetPName("Centers", "Name", "id", l.Text);


            HiddenField h1 = (HiddenField)e.Row.FindControl("HiddenField1");
            HiddenField h2 = (HiddenField)e.Row.FindControl("HiddenField2");
            HiddenField h3 = (HiddenField)e.Row.FindControl("HiddenField3");
            HiddenField h4 = (HiddenField)e.Row.FindControl("HiddenField4");

            string imgUrl = "";
            string alt = "";

            if (h1.Value.Length != 0 && h2.Value.Length == 0)
            {
                imgUrl = "bulletgreen.png";
                alt = "انطلقت";
            }
            else if (h1.Value.Length != 0 && h2.Value.Length != 0 && h3.Value.Length == 0)
            {
                imgUrl = "bulletyellow.png";
                alt = "وصلت مكان التفريغ";
            }
            else if (h1.Value.Length != 0 && h2.Value.Length != 0 && h3.Value.Length != 0 && h4.Value.Length == 0)
            {
                imgUrl = "bulletpurple.png";
                alt = "انطلقت من مكان التفريغ";
            }
            else if (h1.Value.Length != 0 && h2.Value.Length != 0 && h3.Value.Length != 0 && h4.Value.Length != 0)
            {
                imgUrl = "bulletred.png";
                alt = "انهت الرحلة";
            }

            Image i = (Image)e.Row.FindControl("Image1");
            i.ImageUrl = "../images/" + imgUrl;
            i.AlternateText = alt;
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void ImageButton1_Command(object sender, CommandEventArgs e)
    {
        Session["ParameterID"] = e.CommandArgument;
        Response.Redirect("CarMovmentDetails.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="100%" class="LogInTable">
        <tr>
            <td>
                <table class="DataEnterTable" align="center" width="50%">
                    <tr>
                        <td colspan="3" class="Title">
                            الرجاء ادخال التاريخ
                        </td>
                    </tr>
                    <tr align="center" class="tr1">
                        <td>
                            اليوم    
                        </td>
                        <td>
                          الشهر    
                        </td>
                        <td>
                          السنة
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                        
                        
                            <asp:DropDownList ID="DropDownList2" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server">
                            </asp:DropDownList>
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <asp:ImageButton ImageUrl="~/Images/Ok.png" ID="ImageButton1" runat="server" 
                                onclick="ImageButton1_Click" /> 
                            <a href="Default.aspx">
                                <img src="../Images/Cancel.png" border="0" />
                            </a>
                        </td>
                    </tr>
                    
                    <tr>
                        <td colspan="3" align="right">
                            <img align="middle" src="../Images/Ok.png" width="25" /> تنفيذ التقرير
                            &nbsp;&nbsp;&nbsp;
                            <img align="middle" src="../Images/Cancel.png" width="10" /> رجوع
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT Transports.id, Cars.Number as Car_Number, Drivers.Name As Driver_Name, Trailer.Number AS Trailer_Number, Transports.FromId, Transports.ToId, Transports.Tonnage, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.LeavingTime2, Transports.ArrivalTime2 FROM Cars INNER JOIN Drivers INNER JOIN Transports ON Drivers.id = Transports.DriverId INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Cars.id = Transports.CarID where (YEAR(leavingtime1)=@year and MONTH(leavingtime1)=@month and DAY(leavingtime1)=@day)">
                    
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="day" />
                        <asp:ControlParameter ControlID="DropDownList2" Name="month" />
                        <asp:ControlParameter ControlID="DropDownList3" Name="year" />
                    </SelectParameters>    
                
               </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                    DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" 
                    DataKeyNames="id" Width="98%" OnRowDataBound="GridView1_RowDataBound">
                    <RowStyle HorizontalAlign="Center" BackColor="#F7F6F3" ForeColor="#333333" />
                    <Columns>
                        <asp:TemplateField HeaderText="الحالة">
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField1" Value='<%#Eval("LeavingTime1") %>' runat="server" />
                                <asp:HiddenField ID="HiddenField2" Value='<%#Eval("ArrivalTime1") %>' runat="server" />
                                <asp:HiddenField ID="HiddenField3" Value='<%#Eval("LeavingTime2") %>' runat="server" />
                                <asp:HiddenField ID="HiddenField4" Value='<%#Eval("ArrivalTime2") %>' runat="server" />
                                <asp:Image ID="Image1" runat="server" />
                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="id" HeaderText="رقم الرحلة" 
                            SortExpression="id" InsertVisible="False" ReadOnly="True" />
                        
                            
                        
                        <asp:TemplateField HeaderText="من">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("FromId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="الى">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%#Eval("ToId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        
                        
                        <asp:BoundField DataField="Driver_Name" HeaderText="اسم السائق" 
                            SortExpression="Driver_Name" />
                        <asp:BoundField DataField="Car_Number" HeaderText="رقم القاطرة" 
                            SortExpression="Car_Number" />
                        <asp:BoundField DataField="Trailer_Number" HeaderText="رقم المقطورة" 
                            SortExpression="Trailer_Number" />
                        <asp:BoundField DataField="Tonnage" HeaderText="الحمولة" 
                            SortExpression="Tonnage" />
                        <asp:BoundField DataField="LeavingTime1" HeaderText="وقت المغادرة" 
                            SortExpression="LeavingTime1" DataFormatString="{0:t}" >
                        <ItemStyle  />
                        </asp:BoundField>
                        <asp:BoundField DataField="ArrivalTime1" HeaderText="وقت الوصول" 
                            SortExpression="ArrivalTime1" DataFormatString="{0:t}" >
                        <ItemStyle />
                        </asp:BoundField>
                        <asp:BoundField DataField="LeavingTime2" HeaderText="وقت المغادرة" 
                            SortExpression="LeavingTime2" DataFormatString="{0:t}" >
                        <ItemStyle  />
                        </asp:BoundField>
                        <asp:BoundField DataField="ArrivalTime2" HeaderText="وقت الوصول" 
                            SortExpression="ArrivalTime2" DataFormatString="{0:t}" >
                        <ItemStyle  />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="تفاصيل">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/More.png" CommandArgument='<%#Eval("id") %>' runat="server" OnCommand="ImageButton1_Command" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
                
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td>
                            <img src="../Images/bulletgreen.png" />
                        </td>
                        <td>
                            انطلقت
                        </td>
                        <td>
                            <img src="../Images/bulletyellow.png" />
                        </td>
                        <td>
                            وصلت مكان التفريغ
                        </td>
                    </tr>
                    
                    <tr>
                        <td>
                            <img src="../Images/bulletpurple.png" />
                        </td>
                        <td>
                            انهت من التفريغ و انطلقت 
                        </td>
                        <td>
                            <img src="../Images/bulletred.png" />
                        </td>
                        <td>
                            انهت الرحلة
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

