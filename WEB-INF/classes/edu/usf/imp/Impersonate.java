package edu.usf.imp;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import blackboard.data.user.User;
import blackboard.data.user.User.SystemRole;
import blackboard.platform.context.Context;
import blackboard.platform.context.ContextManager;
import blackboard.platform.context.ContextManagerFactory;
import blackboard.platform.security.authentication.BbAuthenticationFailedException;
import blackboard.platform.security.authentication.BbSecurityException;
import blackboard.platform.security.authentication.SessionStub;
import blackboard.persist.*;
import blackboard.persist.user.UserDbLoader;


public class Impersonate {
	BbPersistenceManager bbPm;
	Id userId;
	User user;
	HttpServletRequest impRequest;
	HttpServletResponse impResponse;
	String username;
	private ContextManager contextManager;
	
	public Impersonate(String targetId,HttpServletRequest request, HttpServletResponse response) throws KeyNotFoundException, PersistenceException {
		impRequest = request;
		impResponse = response;
		contextManager = ContextManagerFactory.getInstance();
		username=targetId;
	

		UserDbLoader userLoader = UserDbLoader.Default.getInstance();
		userId = userLoader.loadByUserName(targetId).getId();
			
		
	}
		
	
	public void doImpersonate() throws BbAuthenticationFailedException{

		SessionStub sessionStub;
		
		try {
			sessionStub = new SessionStub(impRequest);
			sessionStub.associateSessionWithUser(username);
		} catch (BbSecurityException e) {
			e.printStackTrace();
		}

		contextManager.purgeContext();
	    contextManager.setContext(impRequest);
		

	}
	
	public boolean checkAuth(Context ctx){
		
		if(ctx.getUser().getSystemRole()==SystemRole.SYSTEM_ADMIN){
			return true;
		}
		

		return false;
	
	}
}