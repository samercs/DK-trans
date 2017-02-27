<%@ Page Title="كشف حمولات الشهر" Language="C#" MasterPageFile="~/Admin/Reports.master" %>

<script runat="server">
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            for (int i = 2010; i <= DateTime.Now.Year; i++)
            {
                years.Items.Add(new ListItem(i.ToString(), i.ToString()));
                years2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            
            for (int i = 1; i <= 12; i++)
            {
                Months.Items.Add(new ListItem(i.ToString(), i.ToString()));
                month2.Items.Add(new ListItem(i.ToString(), i.ToString()));
                
            }
            

            for (int i = 1; i <= 31; i++)
            {
                day.Items.Add(new ListItem(i.ToString(), i.ToString()));
                day2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            years.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            years2.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            Months.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            month2.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            day2.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" Runat="Server">

    <table class="LogInTable" align="center">
        <tr>
            <td class="Title">
                كشف حركات الشهر
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr class="tr2">
                        <td></td>
                        <td>من</td>
                        <td>
                            <asp:DropDownList ID="day" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="Months" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="years" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            الى
                        </td>
                        <td>
                            <asp:DropDownList ID="day2" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="month2" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="years2" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="center">
                              <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton> | 
                                <a onclick="window.print();">طباعة</a>         
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        </table>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">

     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        SelectCommand="SELECT SUM(Tonnage) AS m1, SUM(Tonnage2) AS m2, SUM(Tonnage2) - SUM(Tonnage) AS m3 FROM Transports WHERE (YEAR(LeavingTime1) = @year) AND (MONTH(LeavingTime1) = @month) AND (DAY(LeavingTime1) = @day)">
        <SelectParameters>
            <asp:Parameter Name="year" />
            <asp:Parameter Name="month" />
            <asp:Parameter Name="day" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <%
        
        DateTime st = new DateTime(int.Parse(years.SelectedValue), int.Parse(Months.SelectedValue), int.Parse(day.SelectedValue), 0, 0, 0);
        DateTime en = new DateTime(int.Parse(years2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue)+1, 0, 0, 0);
        
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("select isnull(sum(tonnage),0) as m1,isnull(sum(tonnage2),0) as m2,isnull((sum(tonnage2)-sum(tonnage)),0) as m3 from transports where (year(leavingtime1)=@year and month(leavingtime1)=@month and day(leavingtime1)=@dayv)", con);
        cmd.Parameters.AddWithValue("@year", st.Year);
        cmd.Parameters.AddWithValue("@month", st.Month);
        cmd.Parameters.AddWithValue("@dayv", st.Day);
        System.Data.SqlClient.SqlDataReader r;
        con.Open();
        System.Data.DataTable DT = new System.Data.DataTable();
        DT.Columns.Add("Day");
        DT.Columns.Add("m1",typeof(double));
        DT.Columns.Add("m2",typeof(double));
        DT.Columns.Add("m3",typeof(double));
        System.Data.DataRow row;
        double M1 = 0, M2 = 0, M3 = 0;

        
        while (DateTime.Compare(st,en)<0 )
        {

            r = cmd.ExecuteReader();
            if (r.Read())
            {
                row = DT.NewRow();
                row["day"] = st.Year.ToString() + "/"  + st.Month.ToString("00") + "/" + st.Day.ToString("00"); 
                row["m1"] = r["m1"].ToString();
                row["m2"] = r["m2"].ToString();
                row["m3"] = r["m3"].ToString();
                DT.Rows.Add(row);
                M1 += double.Parse(r["m1"].ToString());
                M2 += double.Parse(r["m2"].ToString());
                M3 += double.Parse(r["m3"].ToString());
            }
            st=st.AddDays(1);
            r.Close();
            cmd.Cancel();
            cmd.Parameters["@year"].Value = st.Year;
            cmd.Parameters["@month"].Value = st.Month;
            cmd.Parameters["@dayv"].Value = st.Day;
            
            
        }

        con.Close();
        row = DT.NewRow();
        row["DAY"]="المجموع";
        row["m1"] = M1.ToString();
        row["m2"] = M2.ToString();
        row["m3"] = M3.ToString();
        DT.Rows.Add(row);
        GridView1.DataSource = DT;
        GridView1.DataBind();
        
        
         %>
    
       
    <asp:GridView AutoGenerateColumns="false" Width="100%" ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" 
        GridLines="None">
        <RowStyle HorizontalAlign="Center" BackColor="#F7F6F3" ForeColor="#333333" />
        
        <Columns>
            <asp:BoundField DataField="day" HeaderText="اليوم" SortExpression="day" />
            <asp:BoundField DataField="m1" HeaderText="مجموع الحمولة" SortExpression="m1" DataFormatString="{0:###,###,###}" />
            <asp:BoundField DataField="m2" HeaderText="مجموع التفريغ" SortExpression="m2" DataFormatString="{0:###,###,###}" />
            <asp:BoundField DataField="m3" HeaderText="مجموع الصافي" SortExpression="m3" DataFormatString="{0:###,###,###}" />
            
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        
    </asp:GridView>
    
</asp:Content>
