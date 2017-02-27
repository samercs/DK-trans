<%@ Page Title="تغير كلمة السر" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

<script runat="server">

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        
        if (DataBase.ChangePassword(Session["id"].ToString(), TextBox1.Text, TextBox2.Text).Equals("done"))
        {
            Message msg = new Message("تم تغير كلمة السر", true, "default.aspx", "default.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
        else
        {
            Message msg = new Message("الرجاء التاكد من كلمة السر الحالية", true, "ChangePassword.aspx", "ChangePassword.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table align="center" class="LogInTable">
        <tr>
            <td colspan="2" class="Title">تغير كلمة السر</td>
        </tr>
        <tr>
            <td>كلمة السر الحالية
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="TextBox1" ErrorMessage="الرجاء ادخال كلمة السر الحالية">*</asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:TextBox CssClass="Text" ID="TextBox1" runat="server" TextMode="Password"></asp:TextBox></td>
        </tr>
        <tr>
            <td>كلمة السر الجديدة
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="TextBox2" ErrorMessage="الرجاء ادخال كلمة السر الجديدة">*</asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:TextBox CssClass="Text" ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox></td>
        </tr>
        <tr>
            <td>تأكيد كلمة السر
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="TextBox3" ErrorMessage="الرجاء ادخال تاكيد كلمة السر">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToCompare="TextBox2" ControlToValidate="TextBox3" 
                    ErrorMessage="الرجاء التاكد من تاكيد كلمة السر">*</asp:CompareValidator>
            </td>
            <td>
                <asp:TextBox CssClass="Text" ID="TextBox3" runat="server" TextMode="Password"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="2" class="Center">
                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تغير</asp:LinkButton> | 
                <a href="Default.aspx">رجوع</a>
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>
    <br />

</asp:Content>

