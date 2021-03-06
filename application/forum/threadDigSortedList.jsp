<%@ page session="false"  %>
<%@ taglib uri="struts-logic" prefix="logic" %>
<%@ taglib uri="struts-bean" prefix="bean" %>
<%@ taglib uri="struts-html" prefix="html" %>
<%@ taglib uri="/WEB-INF/MultiPagesREST.tld" prefix="MultiPagesREST" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<bean:define id="threadList" name="threadListForm" property="list" />
<logic:empty name="threadListForm" property="oneModel">
  <% 
  response.sendError(404);  
  %>
</logic:empty>
<bean:define id="forum" name="threadListForm" property="oneModel"/>
<bean:define id="title" name="forum" property="name" />
<bean:define id="pagestart" name="threadListForm" property="start" />
<bean:define id="pagecount" name="threadListForm" property="count" />
<bean:define id="lastModifiedDate" name="forum" property="modifiedDate2"/>
<%

int pagestartInt = ((Integer)pageContext.getAttribute("pagestart")).intValue();
int pagecountInt = ((Integer)pageContext.getAttribute("pagecount")).intValue();
int currentPageNo = 1;
if (pagecountInt > 0) {
	currentPageNo = (pagestartInt / pagecountInt) + 1;
}
String titleStr = (String)pageContext.getAttribute("title");
if (currentPageNo > 1){
	titleStr = titleStr + "  - 第"+ currentPageNo + "页";
	int expire =5 * 24 * 60 *60;
  long modelLastModifiedDate = com.jdon.jivejdon.presentation.action.util.ForumUtil.getForumsLastModifiedDate(this.getServletContext());
	if (!com.jdon.jivejdon.util.ToolsUtil.checkHeaderCache(expire, modelLastModifiedDate, request, response)) {
		return ;
	}

}
pageContext.setAttribute("title", titleStr);
%>
<%@ include file="../common/IncludeTop.jsp" %>
<link rel="alternate" type="application/rss+xml" title="<bean:write name="title" /> " href="/rss" /> 
<script>
 if(top !== self) top.location = self.location;
  contextpath = "<%=request.getContextPath()%>";
 </script> 
<script language="javascript" defer="defer" src="<html:rewrite page="/forum/js/threadList.js"/>"></script> 

<!-- /////////////////////////////////////////Content -->
<div id="page-content" class="single-page container">
		<div class="row">
			<!-- /////////////////左边 -->
			<div id="main-content" class="col-md-12">
				<div class="box">	
					<ul class="nav nav-tabs">
  <li ><a href="<%=request.getContextPath()%>/threads">时间</a></li>
   <li><a href="<%=request.getContextPath()%>/forum/maxPopThreads">回复</a></li>
  <li class="active"><a href="#">按点赞数排序</a></li>
  
	               <div class="tres" style="float: right;">
        <logic:empty name="forum" property="forumId">
          <MultiPagesREST:pager actionFormName="threadListForm" page="/forum/threadDigSortedList" >
            <MultiPagesREST:prev name=" 上一页 " />
            <MultiPagesREST:index displayCount="3" />
            <MultiPagesREST:next  name=" 下一页 " />
          </MultiPagesREST:pager>
        </logic:empty>
      
         有<b>
        <bean:write name="threadListForm" property="allCount"/>
        </b>贴
       
      </div>
	</ul>          
                    
  <%@ include file="threadListCore.jsp" %>
      
	  <div class="tres">有<b>
                    <bean:write name="threadListForm" property="allCount"/>
                    </b>贴
                    <logic:empty name="forum" property="forumId">
                      <MultiPagesREST:pager actionFormName="threadListForm" page="/forum/threadDigSortedList" >
                        <MultiPagesREST:prev name=" 上一页 " />
                        <MultiPagesREST:index displayCount="3" />
                        <MultiPagesREST:next  name=" 下一页 " />
                      </MultiPagesREST:pager>
                    </logic:empty>
               
                  </div>
				</div>
            </div>	
	</div>
</div>

<%@include file="../common/IncludeBottom.jsp"%>
