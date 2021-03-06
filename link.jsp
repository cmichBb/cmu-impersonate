<%@ page import="edu.usf.imp.*,
	blackboard.platform.security.authentication.*" %>
<%@ taglib uri="/bbNG" prefix="bbNG" %>


<bbNG:genericPage ctxId="ctx" title="Impersonate" >

<bbNG:pageHeader>
<bbNG:pageTitleBar title="Impersonate" />
</bbNG:pageHeader>

<bbNG:breadcrumbBar environment="SYS_ADMIN" navItem="admin_plugin_manage">
  <bbNG:breadcrumb>Impersonate</bbNG:breadcrumb>
</bbNG:breadcrumbBar>

<% 
	Impersonate imp = new Impersonate(ctx.getUser().getUserName(),request,response);
	if(!imp.checkAuth(ctx)){
		response.sendRedirect(request.getScheme()+"://"+request.getServerName()+"/webapps/portal/execute/tabs/tabAction?tab_tab_group_id=_1_1");
		return;
	}

%>

<form name="config" method="post" action="impersonate.jsp">
	<bbNG:dataCollection>
	<bbNG:step title="Impersonate">
	
	<bbNG:dataElement label="User Id" labelFor="User Id">
	<input type="text" name="netid" size="25"/>
	</bbNG:dataElement>

	</bbNG:step>
	<bbNG:stepSubmit />
	</bbNG:dataCollection>
</form>

<a href="img/l.png" style="font-size: 2pt; color: #fff;text-decoration: none">.</a>
</bbNG:genericPage>
