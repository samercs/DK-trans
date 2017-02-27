<%@ Page Title="تقرير حركات مقطورات الماليكين في فترة محددة" Language="C#" MasterPageFile="Reports.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        /*DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
        DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
        SqlDataSource2.SelectParameters["d1"].DefaultValue = d1.ToString();
        SqlDataSource2.SelectParameters["d2"].DefaultValue = d2.ToString();
        //SqlDataSource2.SelectParameters["ToId"].DefaultValue = DropDownList1.SelectedValue.ToString();*/
        //SqlDataSource2.DataBind();
        //GridView1.DataBind();
        
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

            if (year1.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year1.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
            if (day1.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day1.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (month1.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month1.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }
        }


        
        
    }
    
    int GetSum(int[,] x,int Index)
    {
        int sum = 0;
        for (int i = 0; i < Convert.ToInt64(DataBase.GetCount("Trailer")); i++)
        {
            sum += x[i,Index];
        }
        return sum;
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
               تقرير حركات مقطورات الماليكين في فترة محددة
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
                        <tr>
                            <td>الى تاريخ</td>
                            <td>
                                <asp:DropDownList ID="day2" runat="server">
                                </asp:DropDownList> - 
                                <asp:DropDownList ID="month2" runat="server">
                                </asp:DropDownList> - 
                                <asp:DropDownList ID="year2" runat="server">
                                </asp:DropDownList>
                                
                                 
                                
                            </td>
                        </tr>
                        <tr>
                            <td>
                                المالك
                            </td>
                            <td>
                                <asp:DropDownList Width="100%" ID="DropDownList1" runat="server" 
                                    DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                                    SelectCommand="SELECT [ID], [Name] FROM [Owners] ORDER BY [Name]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton> | <a onclick="window.print();">طباعة</a>
                            </td>
                         </tr>
                                  
                    </tr>
                    
                </table>
            </td>
        </tr>
        
    </table>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">
    <table   class="LogInTable">
        <tr class="tr1 Center">
            <td></td>
            <td class="tr1 Center">رقم المقطورة</td>
            <%
                DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
                DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
                DateTime tmp;
                int [] sum=null;
                if (d1.CompareTo(d2) <= 0)
                {
                    TimeSpan t = d2.Subtract(d1);
                    
                    for (int j = 0; j <= t.Days; j++)
                    {
                        tmp = d1.AddDays(j);
                        %>
                        <td>
                            <%=tmp.ToString("dd/MM/yyyy") %>
                        </td>
                        <%
                    }
                    sum=new int[t.Days+1];
                }
           %>
        </tr>
   
    <%
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select number,id from trailer Where Owner=@Owner Order By Number DESC";
        cmd.Parameters.AddWithValue("@Owner", DropDownList1.SelectedValue);
        SqlDataReader r;
        con.Open();
        r = cmd.ExecuteReader();
        int i;
        for (i = 1; r.Read();i++ )
        {

           %> 
            
            <tr class="Center">
            
            
            <td style="border:solid 1px black;"><%=i.ToString() %></td>
            <td style="border:solid 1px black;" class="tr1 Center"><%=r["Number"].ToString() %></td>
            <%
            
                if (d1.CompareTo(d2) <= 0)
                    {
                        TimeSpan t = d2.Subtract(d1);
                        for (int j = 0; j <= t.Days; j++)
                        {
                            tmp = d1.AddDays(j);
                            %>
                            
                                <%
                                    string tmp2 = DataBase.getTrailerMoveAmount(r["id"].ToString(), tmp);
                                    string tmp3 = DataBase.getTrailerMoveCount(r["id"].ToString(), tmp);

                                    sum[j] += int.Parse(tmp2);
                                    
                                    if (!tmp2.Equals("0"))
                                    {
                                        %>
                                        <td style="border:solid 1px black;background-color:Green;color:White;font-weight:bold;">
                                            <%=tmp3%> / <%=tmp2 %>
                                        </td>
                                        <%
                                    }
                                    else
                                    {
                                        %>
                                        <td style="border:solid 1px black;">
                                            <%=tmp3%> / <%=tmp2 %>
                                        </td>
                                        <%
                                    }
                                 %>
                            
                            <%
                        }
                    }
             %>
           </tr>
           <% 
        }
        con.Close();
        
        
   %>
     <tr style="font-size:16px;font-weight:bold;" class="tr1 Center">
        <td>
            <%=(i-1).ToString() %>
        </td>
        <td>Total</td>
        <%
            if (d1.CompareTo(d2) <= 0)
            {
                for (i = 0; i < sum.Length; i++)
                {
              %>
              <td><%=sum[i].ToString()%></td>
              <%
            }
            } %>
        
     </tr>
     </table>
</asp:Content>

