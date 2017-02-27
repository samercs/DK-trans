<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["MSG"] != null)
        {
            Message msg = (Message)Session["MSG"];
            if (msg.TYPE)
            {
                Image1.ImageUrl = "images/ok.png";
            }
            else
            {
                Image1.ImageUrl = "images/Error.png";
            }

            Label1.Text = msg.TXT;
            HyperLink1.NavigateUrl = msg.OKPAGE;
        }
        else
        {
            Label1.Text = "لا يجوز لك الدخول الى هذة الصفحة";
            Image1.ImageUrl = "images/Error.png";
            HyperLink1.NavigateUrl="Default.aspx";
        }
        
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>رسالة</title>
    <link href="StyleSheet.css" type="text/css" rel="Stylesheet" rev="Stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <div>
        <table align="center" class="LogInTable">
        <tr>
            <td>
                
                <asp:Image ID="Image1" ImageAlign="Middle" runat="server" />
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                
            </td>
        </tr>
        <tr>
            <td align="center">
                
                <asp:HyperLink ID="HyperLink1" runat="server">موافق</asp:HyperLink> 
            </td>

        </tr>
    </table>
    </div>
    </form>
</body>
</html>
