<%@ Page Title="حركة الشاحنات" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

<script runat="server">
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("Label1");
            l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
            l = (Label)e.Row.FindControl("Label2");
            l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
            DateTime xx;
            if (DateTime.TryParse(e.Row.Cells[11].Text, out xx))
            {
                e.Row.BackColor = System.Drawing.Color.FromName("#6d9c34");
                e.Row.ForeColor = System.Drawing.Color.White;
            }
            else
            {
                e.Row.BackColor = System.Drawing.Color.FromName("#550000");
                e.Row.ForeColor = System.Drawing.Color.White;
            }
            l = (Label)e.Row.FindControl("no");
            l.Text = (int.Parse(l.Text) - 32).ToString();
        }
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        SqlDataSource1.DataBind();
        GridView1.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int CurentYear = DateTime.Now.Year;
            for (int i = 1; i <= 31; i++)
            {
                if (i <= 12)
                {
                    month1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    
                }
                day1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                

            }
            for (int i = 2010; i <= CurentYear + 1; i++)
            {
                year1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                
            }

            if (day1.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day1.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (month1.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month1.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }

            if (year1.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year1.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
            
            DateTime d1=new DateTime(int.Parse(year1.SelectedValue),int.Parse(month1.SelectedValue),int.Parse(day1.SelectedValue));
            SqlDataSource1.SelectParameters["d1"].DefaultValue = d1.ToString();
            SqlDataSource1.DataBind();
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
        SqlDataSource1.SelectParameters["d1"].DefaultValue = d1.ToString();
        SqlDataSource1.DataBind();
        GridView1.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    
    <ContentTemplate>
    
            <table class="LogInTable" align="center">
                <tr>
                    <td>
                        تاريخ التحميل
                    </td>
                    <td>
                            <asp:DropDownList ID="day1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year1" runat="server">
                            </asp:DropDownList>
                    </td>
                    <td>
                        <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">
                        <img align="middle" border="0" src="../Images/Refresh.png" width="25" height="20"  />
                        تحديث التاريخ
                        </asp:LinkButton>
                    </td>
                </tr>
            </table>
            
            
            
            
            <div class="Center">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT Transports.id, Drivers.Name AS Driver_Name, Transports.FromId, Transports.ToId, Cars.Number AS Car_Number,  Trailer.Number AS Trailer_Number,Transports.Tonnage,Transports.Tonnage2,Transports.LoadNo,Transports.EmptyingNo, Transports.ArrivalTime1, Transports.LeavingTime1 FROM Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id INNER JOIN Cars ON Transports.CarID = Cars.id INNER JOIN Trailer ON Transports.TrailerID = Trailer.id where (DATEDIFF(dd,LeavingTime1,@d1)=0) order by LeavingTime1">
                    <SelectParameters>
                        <asp:Parameter Name="d1" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
             <div class="Title">  تاريخ اخر تحديث <%=DateTime.Now.ToString() %></div>
             <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
                    GridLines="None" Width="98%" HorizontalAlign="Right" 
                        OnRowDataBound="GridView1_RowDataBound" AllowPaging="false" AllowSorting="True" 
                        PageSize="20">
                    <RowStyle BackColor="#F7F6F3" HorizontalAlign="Center" ForeColor="#333333" />
                    <Columns>
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="no" runat="server" Text='<%#Eval("id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="من" SortExpression="FromId">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("FromId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="الى" SortExpression="ToId">
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
                        <asp:BoundField DataField="LeavingTime1" 
                            HeaderText="تاريخ التحميل" SortExpression="LeavingTime1" />
                        <asp:BoundField DataField="Tonnage" 
                            HeaderText="الحمولة" SortExpression="Tonnage" />  
                         <asp:BoundField DataField="LoadNo" 
                            HeaderText="رقم التحميل" SortExpression="LoadNo" /> 
                         <asp:BoundField DataField="EmptyingNo" 
                            HeaderText="رقم التفريغ" SortExpression="EmptyingNo" /> 
                         <asp:BoundField DataField="Tonnage2" 
                            HeaderText="وزن التفريغ" SortExpression="Tonnage2" />
                         <asp:BoundField DataField="ArrivalTime1" 
                            HeaderText="وقت الوصول" SortExpression="ArrivalTime1" />
                                     
                        
                    </Columns>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle HorizontalAlign="Right" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
                </div>
                
                
                
     <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick">
    </asp:Timer>
    </ContentTemplate>
   </asp:UpdatePanel>
   <br />
   <br />
   <br />
   <br />
   <div style="text-align:right;width:100%">
                    <img src="../Images/bulletred.png" align="middle" />
                    الشاحنات بالون الاحمر تعني لم تصل بعد
                    <br />
                    <img src="../Images/bulletgreen.png" align="middle" />
                    الشاحنات بالون الاخضر تعني انها وصلت
   </div>
   <br />
   <br /> 
    
</asp:Content>

