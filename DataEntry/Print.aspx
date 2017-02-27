<%@ Page Title="" Language="C#" MasterPageFile="~/DataEntry/Reports.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["data"] != null)
        {
            GridView1.DataSource = (SqlDataSource)Session["data"];
            GridView1.DataBind();
            Page.Title = Session["Title"].ToString();
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (Session["Parameter"].ToString().Equals("1"))
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label l = (Label)e.Row.FindControl("Label1");
                l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
                l = (Label)e.Row.FindControl("Label2");
                l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
            }
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="Title"> 
    بسم الله الرحمن الرحيم
    <br />
    <br />
    <%=Session["Title"].ToString() %>
    <br />
    <br />
    تاريخ الطباعة : <%=DateTime.Now.ToString() %>
    </div>
    <br />
    
    <asp:GridView ID="GridView1" runat="server">
    </asp:GridView>
</asp:Content>

