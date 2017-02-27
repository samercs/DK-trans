<%@ Page Title="تقرير ملخص الحركات" Language="C#" MasterPageFile="Reports.master" %>

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

        
    }


    
    


    /*private double GetSum(int Index)
    {
        double result = 0;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            result += double.Parse(GridView1.Rows[i].Cells[Index].Text );
        }
        return result;
    }*/
    
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
                تقرير ملخص الحركات
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
                            <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton> | 
                            <a onclick="window.print();">طباعة</a>
                                        
                         </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
        
    </table>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
    
    
    <%
        
        
        System.Data.DataTable Centers = DataBase.GetData("Centers", new string[] { "1" }, new string[] { "1" });
        System.Data.DataTable Owners = DataBase.GetData("Owners", new string[] { "1" }, new string[] { "1" });
        
        
         %>
    
    <table  width="90%">
        <tr style="height:50px;background-color:#cecece;" class="Title" align="center">
            <td>المحطة</td>
            <%
                for (int k = 0; k < Owners.Rows.Count; k++)
                {
                    %>
                    <td>
                        مقطورات <%=Owners.Rows[k]["name"].ToString() %>
                    </td>
                    <%
                }
                 %>
        </tr>
        
        <%for (int i = 0; i < Centers.Rows.Count; i++)
          {
              if (i % 2 == 0)
              {%>
              <tr style="height:50px;background-color:#999999;" align="center">
              <%
              }
              else
              {
                  %>
                  <tr style="height:50px;background-color:#cecece;" align="center">
                  <%
              }
              %>
          
            <td>
                <%=Centers.Rows[i]["Name"].ToString() %>
            </td>
            <%for (int j = 0; j < Owners.Rows.Count; j++)
              {

                  DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
                  DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
                  
                  System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
                  System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("SELECT     COUNT(*) AS Move_Count, SUM(Transports.Tonnage) AS Sum_Tonnage FROM         Transports INNER JOIN Trailer ON Transports.TrailerID = Trailer.id WHERE     (Trailer.Owner = " + Owners.Rows[j]["id"].ToString() + " and Transports.ToId=" + Centers.Rows[i]["id"].ToString() + " and (DATEDIFF(dd,LeavingTime1,'"+d1.ToString()+"')<=0 and DATEDIFF(dd,LeavingTime1,'"+d2.ToString()+"')>=0)) GROUP BY Trailer.Owner", con);
                  System.Data.SqlClient.SqlDataReader r;
                  con.Open();
                  r = cmd.ExecuteReader();
                  if (r.Read())
                  {
                      %>
                    <td>
                    <table>
                        <tr class="tr1">
                            <td>
                            عدد النقلات
                            </td>
                            <td>
                            مجموع الاوزان
                            </td>
                        </tr>
                        <tr class="tr2">
                            <td><%=r["Move_Count"].ToString()%></td>
                            <td><%=r["Sum_Tonnage"].ToString()%></td>
                        </tr>
                    </table>  
                    </td>
                      <%
                }
                else
                {
                  %>
                  <td>
                  <table>
                        <tr class="tr1">
                            <td>
                            عدد النقلات
                            </td>
                            <td>
                            مجموع الاوزان
                            </td>
                        </tr>
                        <tr class="tr2">
                            <td>0</td>
                            <td>0</td>
                        </tr>
                    </table>  
                    </td>
                  <%    
                }

                  r.Close();
                  cmd.Cancel();
                  con.Close();
                  
            %>
               
           <% }} %>
          </tr>
        
        <tr style="background-color:#555555;color:White;font-size:14px;">
            <td align="center">المجاميع</td>
        
         
          <%  
         for (int i = 0; i < Owners.Rows.Count; i++)
         {
             
             DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
             DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
             System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
             System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("SELECT     COUNT(*) AS Move_Count, SUM(Transports.Tonnage) AS Sum_Tonnage FROM         Transports INNER JOIN Trailer ON Transports.TrailerID = Trailer.id WHERE     (Trailer.Owner = " + Owners.Rows[i]["id"].ToString() + " and (DATEDIFF(dd,LeavingTime1,'"+d1.ToString()+"')<=0 and DATEDIFF(dd,LeavingTime1,'"+d2.ToString()+"')>=0)) GROUP BY Trailer.Owner", con);
             System.Data.SqlClient.SqlDataReader r;
             con.Open();
             r = cmd.ExecuteReader();
             if (r.Read())
             {
                 %>
                 <td align="center">
                    <table width="90%">
                        <tr align="center">
                            <td>عدد النقلات</td>
                            <td>مجموع الاوزان</td>
                        </tr>
                        <tr align="center">
                            <td><%=r["Move_Count"].ToString()%></td>
                            <td><%=r["Sum_Tonnage"].ToString()%></td>
                        </tr>
                    </table>
                 </td>
                 <%
                     
             }
             else
             {
                 %>
                 
                 <td>
                    <table width="90%">
                        <tr align="center">
                            <td>عدد النقلات</td>
                            <td>مجموع الاوزان</td>
                        </tr>
                        <tr align="center">
                            <td>0</td>
                            <td>0</td>
                        </tr>
                    </table>
                 </td>
                 
                 <%
             }
             
             
         }
            
            %>
         </tr>
    </table>
    
    
</asp:Content>

