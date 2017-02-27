<%@ Page Title="تقرير الكابونات" Language="C#" MasterPageFile="~/Admin/Reports.master" %>

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
        DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
        DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
        Session["d1"] = d1;
        Session["d2"] = d2;
        Response.Redirect("CaponReport2.aspx");


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
                تقرير الكابونات
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
                        <td align="center">
                             <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton> |  <a onclick="window.print();">طباعة</a>
                        </td> 
                        
                    </tr>
                    
                </table>
            </td>
        </tr>
        
    </table>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">
</asp:Content>

