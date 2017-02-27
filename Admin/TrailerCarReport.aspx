<%@ Page Title="تقرير ملخص حركة المقطورات مع الرؤوس" Language="C#" MasterPageFile="Reports.master" %>

<script runat="server">

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
        DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
        SqlDataSource2.SelectParameters["d1"].DefaultValue = d1.ToString();
        SqlDataSource2.SelectParameters["d2"].DefaultValue = d2.ToString();
        SqlDataSource2.SelectParameters["ToId"].DefaultValue = DropDownList1.SelectedValue.ToString();
        SqlDataSource2.DataBind();
        
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
                    month2.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
                day1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                day2.Items.Add(new ListItem(i.ToString(), i.ToString()));

            }
            for (int i = 2010; i <= CurentYear + 1; i++)
            {
                year1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                year2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            if (day2.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day2.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (month2.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month2.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }

            if (year2.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year2.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
        }
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("Label1");
            l.Text = DataBase.GetPName("Cars", "Number", "id", l.Text);
            l = (Label)e.Row.FindControl("Label2");
            l.Text = DataBase.GetPName("Trailer", "Number", "id", l.Text);
            l = (Label)e.Row.FindControl("no");
            l.Text = (e.Row.RowIndex + 1).ToString();
        }
    }
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" Runat="Server">

<table width="100%">
        <tr>
            <td style="text-align:right;">
            <%=DateTime.Now.ToShortDateString() %>
            </td>
            <td style="text-align:left;">
                <%=DateTime.Now.ToShortTimeString() %>
            </td>
                
        </tr>
    </table>
    <table class="LogInTable" align="center">
        <tr>
            <td class="Title">
                تقرير ملخص حركات المقطورات مع الرؤوس
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr class="tr2">
                        <td>من تاريخ</td>
                        <td>
                            <asp:DropDownList ID="day1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year1" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>الى تاريخ</td>
                        <td>
                            <asp:DropDownList ID="day2" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month2" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year2" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>المحطة</td>
                        <td>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                SelectCommand="SELECT [id], [Name] FROM [Centers]"></asp:SqlDataSource>
                            <asp:DropDownList ID="DropDownList1" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton> | <a onclick="window.print();">طباعة</a>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
        
    </table>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        SelectCommand="SELECT Transports.CarID, Transports.TrailerID, COUNT(*) AS Move_Count,sum(Tonnage) as Tonnage_Sum,sum(Tonnage2) as Tonnage2_Sum,sum(Tonnage-Tonnage2) as Net_Sum FROM Cars INNER JOIN Transports ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id where (DATEDIFF(dd,LeavingTime1,@d1)<=0 and DATEDIFF(dd,LeavingTime1,@d2)>=0 and Transports.ToId=@ToId) GROUP BY Transports.CarID, Transports.TrailerID">
        
        <SelectParameters>
            <asp:Parameter Name="ToId" />
            <asp:Parameter Name="d1" />
            <asp:Parameter Name="d2" />
        </SelectParameters>
        
        </asp:SqlDataSource>
    <asp:GridView AllowSorting="true" ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" 
        GridLines="None" onrowdatabound="GridView1_RowDataBound" Width="100%">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
        <EmptyDataRowStyle HorizontalAlign="Center" CssClass="Title" />
        <EmptyDataTemplate>
            لا يوجد بيانات
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="no" runat="server" Text=""></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField SortExpression="CarId" HeaderText="رقم القاطرة">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("carId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField SortExpression="TrailerId" HeaderText="رقم المقطورة">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("TrailerId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Move_Count" HeaderText="عدد النقلات" ReadOnly="True" 
                SortExpression="Move_Count" />
                
            <asp:BoundField DataFormatString="{0:###,###,###}" DataField="Tonnage_Sum" HeaderText="مجموع الحمولة" ReadOnly="True" 
                SortExpression="Tonnage_Sum" />
            <asp:BoundField DataFormatString="{0:###,###,###}" DataField="Tonnage2_Sum" HeaderText="مجموع التفريغ" ReadOnly="True" 
                SortExpression="Tonnage2_Sum" />
            <asp:BoundField DataFormatString="{0:###,###,###}" DataField="Net_Sum" HeaderText="مجموع الصافي" ReadOnly="True" 
                SortExpression="Net_Sum" />
            
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>

</asp:Content>

