<%@ Page Title="تقرير الحركات حسب رقم المنافيست" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

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

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["d1"].DefaultValue=month1.SelectedValue + "-" + day1.SelectedValue + "-" + year1.SelectedValue;
           
        SqlDataSource1.SelectParameters["d2"].DefaultValue=month2.SelectedValue + "-" + day2.SelectedValue + "-" + year2.SelectedValue;
        SqlDataSource1.DataBind();
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <table width="100%" class="LogInTable">
        <tr>
            <td>
                
                
                <table align="center" class="DataEnterTable">
                    <tr align="center">
                        <td>
                            من تاريخ
                        </td>
                        <td></td>
                        <td>
                            الى تاريخ
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            
                            <asp:DropDownList ID="day1" runat="server">
                            </asp:DropDownList>
                            -
                            <asp:DropDownList ID="month1" runat="server">
                            </asp:DropDownList>
                            -
                            <asp:DropDownList ID="year1" runat="server">
                            </asp:DropDownList>
                        </td>
                        
                        <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                        
                        <td>
                            
                            <asp:DropDownList ID="day2" runat="server">
                            </asp:DropDownList>
                            -
                            <asp:DropDownList ID="month2" runat="server">
                            </asp:DropDownList>
                            -
                            <asp:DropDownList ID="year2" runat="server">
                            </asp:DropDownList>
                        
                        </td>
                    </tr>
                    <tr align="center">
                        <td colspan="3">
                            <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton>
                        </td>
                    </tr>
                </table>
                
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT ManafestNo, Tonnage, LeavingTime1 FROM Transports WHERE (DATEDIFF(dd, LeavingTime1, @d1) &lt;= 0) AND (DATEDIFF(dd, LeavingTime1, @d2) &gt;= 0)">
                    <SelectParameters>
                        <asp:Parameter Name="d1" />
                        <asp:Parameter Name="d2" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" 
                    GridLines="None" Width="90%">
                    <RowStyle HorizontalAlign="Center" BackColor="#F7F6F3" ForeColor="#333333" />
                    <Columns>
                        <asp:BoundField DataField="ManafestNo" HeaderText="رقم المنافست" 
                            SortExpression="ManafestNo" />
                        <asp:BoundField DataField="Tonnage" HeaderText="الحمولة /الطن" 
                            SortExpression="Tonnage" />
                        <asp:BoundField DataField="LeavingTime1" HeaderText="تاريخ و ساعة المغادرة" 
                            SortExpression="LeavingTime1" />
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
    </table>

</asp:Content>

