<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.usermgmt.model.Appointment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>All Appointments</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
    <script>tailwind.config={theme:{extend:{fontFamily:{sora:['Sora','sans-serif'],dm:['DM Sans','sans-serif']}}}}</script>
</head>
<body class="font-dm bg-gray-50 min-h-screen">

<nav class="bg-[#0d1b3e] sticky top-0 z-50 shadow-lg">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
        <a href="index.jsp" class="flex items-center gap-3 text-white font-sora font-semibold text-lg">
            RealEstate Pro
        </a>
        <div class="flex items-center gap-1">
            <a href="book-appointment.jsp" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">Book Appointment</a>
            <a href="AppointmentServlet?action=list" class="bg-[#4f8ef7] text-white px-4 py-2 rounded-lg text-sm">All Appointments</a>
            <a href="search-appointment.jsp" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">Search</a>
        </div>
    </div>
</nav>

<main class="max-w-7xl mx-auto px-6 py-10">
    <div class="flex items-end justify-between mb-6">
        <div>
            <h1 class="font-sora text-2xl font-semibold text-gray-800">Appointments</h1>
            <p class="text-gray-500 text-sm mt-1">Manage all client appointments.</p>
        </div>
        <a href="book-appointment.jsp" class="bg-[#4f8ef7] hover:bg-blue-500 text-white font-sora font-semibold px-5 py-2.5 rounded-xl text-sm transition">+ Book appointment</a>
    </div>

    <% String success = (String) request.getAttribute("success");
        String error = (String) request.getAttribute("error");
        if (success != null) { %>
    <div class="bg-green-50 border border-green-200 text-green-800 rounded-xl px-4 py-3 text-sm mb-6"><%= success %></div>
    <% } else if (error != null) { %>
    <div class="bg-red-50 border border-red-200 text-red-800 rounded-xl px-4 py-3 text-sm mb-6"><%= error %></div>
    <% } %>

    <%
        List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
        int total = appointments != null ? appointments.size() : 0;
        int confirmed = 0; int pending = 0; int completed = 0;
        if (appointments != null) for (Appointment a : appointments) {
            if ("Confirmed".equals(a.getStatus())) confirmed++;
            if ("Pending".equals(a.getStatus())) pending++;
            if ("Completed".equals(a.getStatus())) completed++;
        }
    %>

    <div class="grid grid-cols-4 gap-4 mb-6">
        <div class="bg-white border border-gray-200 rounded-2xl p-4">
            <div class="text-xs text-gray-400 uppercase tracking-wide mb-1">Total</div>
            <div class="font-sora text-2xl font-semibold text-gray-800"><%= total %></div>
        </div>
        <div class="bg-white border border-gray-200 rounded-2xl p-4">
            <div class="text-xs text-gray-400 uppercase tracking-wide mb-1">Pending</div>
            <div class="font-sora text-2xl font-semibold text-yellow-600"><%= pending %></div>
        </div>
        <div class="bg-white border border-gray-200 rounded-2xl p-4">
            <div class="text-xs text-gray-400 uppercase tracking-wide mb-1">Confirmed</div>
            <div class="font-sora text-2xl font-semibold text-blue-600"><%= confirmed %></div>
        </div>
        <div class="bg-white border border-gray-200 rounded-2xl p-4">
            <div class="text-xs text-gray-400 uppercase tracking-wide mb-1">Completed</div>
            <div class="font-sora text-2xl font-semibold text-green-600"><%= completed %></div>
        </div>
    </div>

    <div class="flex gap-3 mb-5">
        <input type="text" id="searchInput" placeholder="Search by client, agent, property..." oninput="filterTable()"
               class="flex-1 px-4 py-2.5 border border-gray-200 rounded-xl bg-white text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
        <select id="statusFilter" onchange="filterTable()"
                class="px-4 py-2.5 border border-gray-200 rounded-xl bg-white text-sm focus:outline-none focus:border-blue-400">
            <option value="">All status</option>
            <option value="Pending">Pending</option>
            <option value="Confirmed">Confirmed</option>
            <option value="Completed">Completed</option>
            <option value="Cancelled">Cancelled</option>
        </select>
        <select id="typeFilter" onchange="filterTable()"
                class="px-4 py-2.5 border border-gray-200 rounded-xl bg-white text-sm focus:outline-none focus:border-blue-400">
            <option value="">All types</option>
            <option value="Property Viewing">Property Viewing</option>
            <option value="Consultation">Consultation</option>
            <option value="Document Signing">Document Signing</option>
            <option value="Follow Up">Follow Up</option>
        </select>
    </div>

    <div class="bg-white border border-gray-200 rounded-2xl overflow-hidden">
        <table id="aptTable" class="w-full border-collapse">
            <thead class="bg-gray-50 border-b border-gray-200">
            <tr>
                <th class="px-4 py-3 text-left text-xs font-semibold text-gray-400 uppercase tracking-wide">ID</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-gray-400 uppercase tracking-wide">Client</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-gray-400 uppercase tracking-wide">Agent</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-gray-400 uppercase tracking-wide">Property</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-gray-400 uppercase tracking-wide">Date & Time</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-gray-400 uppercase tracking-wide">Type</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-gray-400 uppercase tracking-wide">Status</th>
                <th class="px-4 py-3 text-left text-xs font-semibold text-gray-400 uppercase tracking-wide">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (appointments == null || appointments.isEmpty()) { %>
            <tr><td colspan="8" class="text-center py-12 text-gray-400 text-sm">
                No appointments found. <a href="book-appointment.jsp" class="text-blue-500 hover:underline">Book the first one.</a>
            </td></tr>
            <% } else { for (Appointment a : appointments) {
                String sc = "bg-yellow-100 text-yellow-800";
                if ("Confirmed".equals(a.getStatus())) sc = "bg-blue-100 text-blue-800";
                else if ("Completed".equals(a.getStatus())) sc = "bg-green-100 text-green-800";
                else if ("Cancelled".equals(a.getStatus())) sc = "bg-red-100 text-red-800";
            %>
            <tr class="border-b border-gray-100 hover:bg-gray-50 transition"
                data-search="<%= (a.getClientName()+" "+a.getAgentId()+" "+a.getPropertyId()).toLowerCase() %>"
                data-status="<%= a.getStatus() %>"
                data-type="<%= a.getType() %>">
                <td class="px-4 py-3">
                    <code class="text-xs bg-gray-100 px-2 py-1 rounded-lg"><%= a.getAppointmentId() %></code>
                </td>
                <td class="px-4 py-3">
                    <div class="font-medium text-sm text-gray-800"><%= a.getClientName() %></div>
                    <div class="text-xs text-gray-400"><%= a.getClientEmail() %></div>
                </td>
                <td class="px-4 py-3 text-sm text-gray-600"><%= a.getAgentId() != null ? a.getAgentId() : "—" %></td>
                <td class="px-4 py-3 text-sm text-gray-600"><%= a.getPropertyId() != null ? a.getPropertyId() : "—" %></td>
                <td class="px-4 py-3">
                    <div class="text-sm text-gray-800"><%= a.getDate() %></div>
                    <div class="text-xs text-gray-400"><%= a.getTime() %></div>
                </td>
                <td class="px-4 py-3">
                    <span class="bg-purple-100 text-purple-800 text-xs font-semibold px-2.5 py-1 rounded-full"><%= a.getType() %></span>
                </td>
                <td class="px-4 py-3">
                    <span class="text-xs font-semibold px-2.5 py-1 rounded-full <%= sc %>"><%= a.getStatus() %></span>
                </td>
                <td class="px-4 py-3">
                    <div class="flex gap-2">
                        <a href="AppointmentServlet?action=search&appointmentId=<%= a.getAppointmentId() %>"
                           class="text-xs border border-gray-200 bg-white hover:bg-gray-50 text-gray-700 px-3 py-1.5 rounded-lg transition">Edit</a>
                        <form action="AppointmentServlet" method="post" style="display:inline;" onsubmit="return confirm('Cancel appointment <%= a.getAppointmentId() %>?')">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="appointmentId" value="<%= a.getAppointmentId() %>"/>
                            <button type="submit" class="text-xs border border-red-200 bg-white hover:bg-red-50 text-red-600 px-3 py-1.5 rounded-lg transition">Cancel</button>
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
        const type = document.getElementById('typeFilter').value;
        document.querySelectorAll('#aptTable tbody tr[data-search]').forEach(row => {
            const ms = !q || row.dataset.search.includes(q);
            const mst = !status || row.dataset.status === status;
            const mt = !type || row.dataset.type === type;
            row.style.display = ms && mst && mt ? '' : 'none';
        });
    }
</script>
</body>
</html>