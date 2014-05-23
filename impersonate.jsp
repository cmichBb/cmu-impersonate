<%@ page import="java.util.*,
	java.net.*,
	java.io.*,
	blackboard.platform.session.*, 
	blackboard.data.user.*, 
	blackboard.persist.* ,
	blackboard.persist.user.*,
	blackboard.platform.context.ContextManager,
	blackboard.platform.context.Context,
	blackboard.platform.*,
	blackboard.platform.security.authentication.*,
	edu.usf.imp.*" 
	%>

<%@ taglib uri="/bbData" prefix="bbData"%>
<%@ taglib uri="/bbNG" prefix="bbNG" %>
<%


%>

<bbData:context id="ctx">
<bbNG:breadcrumbBar navItem="admin_plugin_manage" >
  <bbNG:breadcrumb>Impersonate</bbNG:breadcrumb>
</bbNG:breadcrumbBar>

<bbNG:genericPage ctxId="ctx" title="Impersonate" >


<bbNG:pageHeader>
<bbNG:pageTitleBar title="Impersonate" />
</bbNG:pageHeader>

<%

	String netid = request.getParameter("netid");
	Impersonate imp=null;
	try{
		imp = new Impersonate(netid,request,response);

		if(!imp.checkAuth(ctx)){
			response.sendRedirect(request.getScheme()+"://"+request.getServerName()+"/webapps/portal/execute/tabs/tabAction?tab_tab_group_id=_1_1");
			return;
		}
		
		imp.doImpersonate();
		
		//write a line to System.out.  This will normally 
	    //place a link in BB's stdout file for some hackish logging.
	    System.out.println("[Impersonate] User "+ctx.getUser().getUserName()+" is now impersonating user "+netid+". Bon voyage!");
		
		response.sendRedirect(request.getScheme()+"://"+request.getServerName()+"/webapps/portal/execute/tabs/tabAction?tab_tab_group_id=_1_1");
		

	}
	catch(BbAuthenticationFailedException e){
		out.println("You must have a System Administrator roll to do this.");
	}
	catch (PersistenceException pe){
		out.println("User not found.");
	}



%>

<bbNG:okButton/>

</bbNG:genericPage>
</bbData:context>