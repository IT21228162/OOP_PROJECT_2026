<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.usermgmt.model.Agent" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>All Agents</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@500;600&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['DM Sans','sans-serif'], sora: ['Sora','sans-serif'] },
                    colors: { navy: '#0d1b3e', accent: '#4f8ef7' }
                }
            }
        }
    </script>
</head>
<body class="bg-slate-50 font-sans min-h-screen">

<!-- Navbar -->
<nav class="bg-navy h-14 flex items-center justify-between px-6 sticky top-0 z-10">
    <a href="index.jsp" class="flex items-center gap-2 no-underline">
        <span class="font-sora font-semibold text-white text-base">RealEstate</span>
    </a>
    <div class="flex gap-1">
        <a href="register-agent.jsp" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">Register agent</a>
        <a href="AgentServlet?action=list" class="px-3 py-1.5 rounded-md bg-accent text-white text-sm no-underline">All agents</a>
        <a href="search-agent.jsp" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">Search agent</a>
    </div>
</nav>

<main class="max-width-[1100px] mx-auto px-6 py-8" style="max-width:1100px">

    <!-- Page header -->
    <div class="flex items-end justify-between mb-5">
        <div>
            <h1 class="font-sora text-xl font-semibold text-slate-800 mb-0.5">Agent management</h1>
            <p class="text-sm text-slate-500">Manage all registered real estate agents.</p>
        </div>
        <a href="register-agent.jsp" class="px-4 py-2 bg-accent text-white rounded-lg text-sm font-semibold no-underline hover:bg-blue-500 transition-colors">+ New agent</a>
    </div>

    <!-- Alerts -->
    <% String success=(String)request.getAttribute("success"); String error=(String)request.getAttribute("error");
        if(success!=null){ %><div class="bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-lg px-4 py-3 text-sm mb-5"><%= success %></div>
    <% } else if(error!=null){ %><div class="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm mb-5"><%= error %></div>
    <% } %>

    <%
        List<Agent> agents = (List<Agent>) request.getAttribute("agents");
        int total = agents != null ? agents.size() : 0;
        int active = 0;
        if (agents != null) for (Agent a : agents) if ("Active".equals(a.getStatus())) active++;
    %>

    <!-- Stats -->
    <div class="grid grid-cols-3 gap-3 mb-5">
        <div class="bg-white border border-slate-200 rounded-lg px-5 py-4">
            <p class="text-xs text-slate-400 uppercase tracking-wide mb-1">Total agents</p>
            <p class="font-sora text-2xl font-semibold text-slate-800"><%= total %></p>
        </div>
        <div class="bg-white border border-slate-200 rounded-lg px-5 py-4">
            <p class="text-xs text-slate-400 uppercase tracking-wide mb-1">Active</p>
            <p class="font-sora text-2xl font-semibold text-slate-800"><%= active %></p>
        </div>
        <div class="bg-white border border-slate-200 rounded-lg px-5 py-4">
            <p class="text-xs text-slate-400 uppercase tracking-wide mb-1">Inactive</p>
            <p class="font-sora text-2xl font-semibold text-slate-800"><%= total - active %></p>
        </div>
    </div>

    <!-- Filters -->
    <div class="flex gap-3 mb-4">
        <input type="text" id="searchInput" placeholder="Search by name, email, location…" oninput="filterTable()"
               class="flex-1 px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent"/>
        <select id="statusFilter" onchange="filterTable()"
                class="px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white text-slate-700 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent">
            <option value="">All status</option>
            <option>Active</option><option>Inactive</option><option>On Leave</option>
        </select>
        <select id="specFilter" onchange="filterTable()"
                class="px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white text-slate-700 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent">
            <option value="">All specializations</option>
            <option>Residential</option><option>Commercial</option><option>Industrial</option><option>Land</option><option>Luxury</option>
        </select>
    </div>

    <!-- Table -->
    <div class="bg-white border border-slate-200 rounded-xl overflow-hidden">
        <table id="agentTable" class="w-full border-collapse">
            <thead class="bg-slate-50 border-b border-slate-200">
            <tr>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Agent</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Agent ID</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Phone</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Specialization</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Location</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Exp</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Status</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-400 uppercase tracking-wide">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (agents == null || agents.isEmpty()) { %>
            <tr>
                <td colspan="8" class="text-center py-12 text-slate-400 text-sm">
                    No agents found. <a href="register-agent.jsp" class="text-accent">Register the first one.</a>
                </td>
            </tr>
            <% } else { for (Agent a : agents) {
                String initials = "";
                if (a.getFirstName()!=null&&!a.getFirstName().isEmpty()) initials+=a.getFirstName().charAt(0);
                if (a.getLastName()!=null&&!a.getLastName().isEmpty()) initials+=a.getLastName().charAt(0);
                String statusCls = "Active".equals(a.getStatus()) ? "bg-emerald-50 text-emerald-700"
                        : "Inactive".equals(a.getStatus()) ? "bg-red-50 text-red-700"
                          : "bg-amber-50 text-amber-700";
            %>
            <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors"
                data-search="<%= (a.getFirstName()+" "+a.getLastName()+" "+a.getEmail()+" "+a.getLocation()).toLowerCase() %>"
                data-status="<%= a.getStatus() %>"
                data-spec="<%= a.getSpecialization() %>">
                <td class="px-4 py-3">
                    <div class="flex items-center gap-2.5">
                        <div class="w-8 h-8 rounded-full bg-blue-100 text-blue-700 flex items-center justify-center text-xs font-semibold flex-shrink-0">
                            <%= initials.toUpperCase() %>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-slate-800 leading-none mb-0.5"><%= a.getFirstName() %> <%= a.getLastName() %></p>
                            <p class="text-xs text-slate-400"><%= a.getEmail() %></p>
                        </div>
                    </div>
                </td>
                <td class="px-4 py-3">
                    <code class="text-xs bg-slate-100 text-slate-600 px-2 py-0.5 rounded"><%= a.getAgentId() %></code>
                </td>
                <td class="px-4 py-3 text-sm text-slate-400"><%= a.getPhone()!=null ? a.getPhone() : "—" %></td>
                <td class="px-4 py-3">
                    <span class="inline-flex px-2.5 py-0.5 rounded-full text-xs font-semibold bg-violet-50 text-violet-700"><%= a.getSpecialization() %></span>
                </td>
                <td class="px-4 py-3 text-sm text-slate-700"><%= a.getLocation()!=null ? a.getLocation() : "—" %></td>
                <td class="px-4 py-3 text-sm text-slate-700"><%= a.getExperience() %> yrs</td>
                <td class="px-4 py-3">
                    <span class="inline-flex px-2.5 py-0.5 rounded-full text-xs font-semibold <%= statusCls %>"><%= a.getStatus() %></span>
                </td>
                <td class="px-4 py-3">
                    <div class="flex gap-2">
                        <a href="AgentServlet?action=search&agentId=<%= a.getAgentId() %>"
                           class="px-3 py-1 rounded-md text-xs font-medium border border-slate-200 bg-white text-slate-700 no-underline hover:bg-slate-50 transition-colors">Edit</a>
                        <form action="AgentServlet" method="post" class="inline" onsubmit="return confirm('Delete agent <%= a.getAgentId() %>?')">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="agentId" value="<%= a.getAgentId() %>"/>
                            <button type="submit" class="px-3 py-1 rounded-md text-xs font-medium border border-red-200 text-red-500 bg-transparent hover:bg-red-50 cursor-pointer transition-colors">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <% } } %>
            </tbody>
        </table>
    </div>
</main>

<script>
    function filterTable() {
        const q = document.getElementById('searchInput').value.toLowerCase();
        const status = document.getElementById('statusFilter').value;
        const spec = document.getElementById('specFilter').value;
        document.querySelectorAll('#agentTable tbody tr[data-search]').forEach(row => {
            const ms  = !q      || row.dataset.search.includes(q);
            const mst = !status || row.dataset.status === status;
            const msp = !spec   || row.dataset.spec   === spec;
            row.style.display = ms && mst && msp ? '' : 'none';
        });
    }
</script>
</body>
</html>