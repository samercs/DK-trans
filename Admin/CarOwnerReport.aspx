<%@ Page Title="	تقرير المالكين لرؤوس القاطرة" Language="C#" MasterPageFile="Reports.master" %>

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
        DateTime d1=new DateTime(int.Parse(year1.SelectedValue),int.Parse(month1.SelectedValue),int.Parse(day1.SelectedValue));
        DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
        Session["d1"] = d1;
        Session["d2"] = d2;
        Session["owner"]=DropDownList1.SelectedValue;
        Session["from"] = From.SelectedValue;
        Session["to"] = To.SelectedValue;
        Response.Redirect("CarOwnerReport2.aspx");
        
        
    }


    

    

    
    
</script>

<asp:Content ContentPlaceHolderID="Header" ID="C1" runat="server">
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
                تقرير المالكين لرؤوس القاطرة
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
                        <td>
                           المالك 
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" 
                                DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="ID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                SelectCommand="SELECT [ID], [Name] FROM [Owners]"></asp:SqlDataSource>
                        </td>
                        <td>
                            من 
                        </td>
                        <td>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                SelectCommand="SELECT [id], [Name] FROM [Centers] ORDER BY [Name]"></asp:SqlDataSource>
                            <asp:DropDownList ID="From" runat="server" 
                                DataSourceID="SqlDataSource3" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                        </td>
                        <td>
                            الى 
                        </td>
                        <td>
                           
                            <asp:DropDownList ID="To" runat="server" 
                                DataSourceID="SqlDataSource3" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                        </td>
                        <td align="center">
                             <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton>                             
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
        
    </table>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
    
    
</asp:Content>

