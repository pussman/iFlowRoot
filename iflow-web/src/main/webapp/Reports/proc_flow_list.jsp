<!--
    Infosistema iFlow - workflow and BPM platform
    Copyright(C) 2002-2012 Infosistema, S.A.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    www.infosistema.com
    iflow@infosistema.com
    Av. Jose Gomes Ferreira, 11 3rd floor, s.34
    Miraflores
    1495-139 Alges Portugal
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/core" prefix="c" %>
<%@ taglib uri="http://www.iknow.pt/jsp/jstl/iflow" prefix="if" %>
<%@ include file = "../inc/defs.jsp" %>
<%
{
  
// show nothing if not admin
%><if:checkUserAdmin type="spv"> </if:checkUserAdmin><%

int flowidSel=-1;
try {
  String sflowidSel = fdFormData.getParameter("flowid");
  if(null == sflowidSel) sflowidSel="-1";
  flowidSel=Integer.parseInt(sflowidSel);
} catch(Exception e) {}


IFlowData[] fdaSel;

// TODO checkbox para fluxos online/offline
if(StringUtils.equals("true", fdFormData.getParameter("offline")))
  fdaSel = BeanFactory.getFlowHolderBean().listFlows(userInfo, FlowType.WORKFLOW);
else
  fdaSel = BeanFactory.getFlowHolderBean().listFlowsOnline(userInfo, FlowType.WORKFLOW);

if (fdaSel == null) fdaSel = new IFlowData[0];
%>
<option value="-1" <%= -1==flowidSel?"selected='selected'":"" %>><if:message string="const.all"/></option>
<% 
for(int i=0; i < fdaSel.length; i++) { 
     if (userInfo.isOrgAdmin() || userInfo.isProcSupervisor(fdaSel[i].getId())) {
 		%>
<option value='<%=fdaSel[i].getId()%>'  <%= fdaSel[i].getId()==flowidSel?"selected='selected'":"" %>><%= fdaSel[i].getName() %></option>
<%    
     }
}

}
%>
