<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["id"] != null)
        {
            if (Application["User" + Session["id"].ToString()] != null)
            {
                Application["User" + Session["id"].ToString()] = "false";
            }
        }
        Session.Clear();
        HttpCookie c = new HttpCookie("Data2");
        c.Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(c);
        Response.Redirect("../Default.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

