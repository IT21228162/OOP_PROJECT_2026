<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.usermgmt.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>All Users — UserVault</title>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --navy: #0d1b3e; --accent: #4f8ef7; --surface: #f5f7fb;
            --white: #ffffff; --border: #e2e8f0; --text: #1e293b;
            --muted: #64748b; --danger: #ef4444; --danger-bg: #fee2e2;
            --success: #10b981; --radius: 12px; --radius-sm: 8px;
        }
        body { font-family: 'DM Sans', sans-serif; background: var(--surface); min-height: 100vh; }
        nav { background: var(--navy); padding: 0 2rem; height: 60px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; }
        .brand { font-family: 'Sora', sans-serif; font-weight: 600; font-size: 1.15rem; color: #fff; display: flex; align-items: center; gap: 8px; text-decoration: none; }
        .brand-icon { width: 28px; height: 28px; background: var(--accent); border-radius: 6px; display: flex; align-items: center; justify-content: center; font-size: 14px; color: #fff; font-weight: 700; }
        .nav-links { display: flex; gap: 4px; }
        .nav-link { padding: 6px 14px; border-radius: var(--radius-sm); color: rgba(255,255,255,0.7); font-size: 0.875rem; text-decoration: none; }
        .nav-link.active { background: var(--accent); color: #fff; }
        main { max-width: 1080px; margin: 0 auto; padding: 2.5rem 1.5rem; }
        .page-header { display: flex; align-items: flex-end; justify-content: space-between; margin-bottom: 1.5rem; }
        .page-title { font-family: 'Sora', sans-serif; font-size: 1.4rem; font-weight: 600; color: var(--text); }
        .page-subtitle { font-size: 0.85rem; color: var(--muted); margin-top: 2px; }
        .btn-new { padding: 9px 18px; background: var(--accent); color: #fff; border: none; border-radius: var(--radius-sm); cursor: pointer; font-family: 'Sora', sans-serif; font-size: 0.85rem; font-weight: 600; text-decoration: none; }
        .stats { display: flex; gap: 1rem; margin-bottom: 1.5rem; }
        .stat-card { background: var(--white); border: 1px solid var(--border); border-radius: var(--radius-sm); padding: 1rem 1.25rem; flex: 1; }
        .stat-label { font-size: 0.75rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.4px; margin-bottom: 4px; }
        .stat-value { font-family: 'Sora', sans-serif; font-size: 1.4rem; font-weight: 600; color: var(--text); }
        .search-row { display: flex; gap: 0.75rem; margin-bottom: 1.25rem; }
        .search-input { flex: 1; padding: 9px 12px; border: 1px solid var(--border); border-radius: var(--radius-sm); font-family: 'DM Sans', sans-serif; font-size: 0.875rem; outline: none; background: var(--white); }
        .search-input:focus { border-color: var(--accent); }
        .filter-select { padding: 9px 12px; border: 1px solid var(--border); border-radius: var(--radius-sm); font-family: 'DM Sans', sans-serif; font-size: 0.875rem; background: var(--white); color: var(--text); outline: none; }
        .table-wrap { background: var(--white); border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        thead { background: var(--surface); border-bottom: 1px solid var(--border); }
        th { padding: 11px 16px; text-align: left; font-size: 0.72rem; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; }
        td { padding: 13px 16px; border-bottom: 1px solid var(--border); font-size: 0.875rem; color: var(--text); }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: var(--surface); }
        .avatar { width: 34px; height: 34px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.75rem; font-weight: 600; flex-shrink: 0; }
        .user-cell { display: flex; align-items: center; gap: 10px; }
        .user-name { font-weight: 500; font-size: 0.875rem; color: var(--text); }
        .user-email { font-size: 0.75rem; color: var(--muted); }
        .badge { display: inline-flex; padding: 3px 10px; border-radius: 20px; font-size: 0.72rem; font-weight: 600; }
        .badge-admin { background: #ede9fe; color: #5b21b6; }
        .badge-user { background: #dbeafe; color: #1e40af; }
        .badge-moderator { background: #d1fae5; color: #065f46; }
        .actions { display: flex; gap: 6px; }
        .btn-action { padding: 5px 12px; border-radius: 6px; font-size: 0.78rem; font-weight: 500; cursor: pointer; border: 1px solid var(--border); background: var(--white); text-decoration: none; font-family: 'DM Sans', sans-serif; color: var(--text); }
        .btn-delete { border-color: #fca5a5; color: var(--danger); }
        .btn-delete:hover { background: var(--danger-bg); }
        .empty { text-align: center; padding: 3rem; color: var(--muted); font-size: 0.9rem; }
        .alert { padding: 11px 14px; border-radius: var(--radius-sm); font-size: 0.875rem; margin-bottom: 1.25rem; }
        .alert-success { background: #d1fae5; color: #065f46; border: 1px solid #6ee7b7; }
        .alert-danger { background: var(--danger-bg); color: #7f1d1d; border: 1px solid #fca5a5; }
        .av0 { background: #dbeafe; color: #1e40af; }
        .av1 { background: #ede9fe; color: #5b21b6; }
        .av2 { background: #d1fae5; color: #065f46; }
        .av3 { background: #fef3c7; color: #92400e; }
        .av4 { background: #fee2e2; color: #991b1b; }
    </style>
</head>
<body>
<nav>
    <a href="index.jsp" class="brand"><div class="brand-icon">U</div>UserVault</a>
    <div class="nav-links">
        <a href="register.jsp" class="nav-link">Register</a>
        <a href="UserServlet?action=list" class="nav-link active">All Users</a>
        <a href="search.jsp" class="nav-link">Search</a>
    </div>
</nav>
<main>
    <div class="page-header">
        <div>
            <div class="page-title">User management</div>
            <div class="page-subtitle">Manage all registered accounts in the system.</div>
        </div>
        <a href="register.jsp" class="btn-new">+ New user</a>
    </div>
    <% String success = (String) request.getAttribute("success");
        String error = (String) request.getAttribute("error");
        if (success != null) { %>
    <div class="alert alert-success"><%= success %></div>
    <% } else if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>
    <% List<User> users = (List<User>) request.getAttribute("users");
        int total = users != null ? users.size() : 0;
        int admins = 0;
        if (users != null) for (User u : users) if ("Admin".equals(u.getRole())) admins++;
    %>
    <div class="stats">
        <div class="stat-card"><div class="stat-label">Total users</div><div class="stat-value"><%= total %></div></div>
        <div class="stat-card"><div class="stat-label">Admins</div><div class="stat-value"><%= admins %></div></div>
        <div class="stat-card"><div class="stat-label">Regular users</div><div class="stat-value"><%= total - admins %></div></div>
    </div>
    <div class="search-row">
        <input type="text" class="search-input" id="searchInput" placeholder="Search by name, email or username…" oninput="filterTable()"/>
        <select class="filter-select" id="roleFilter" onchange="filterTable()">
            <option value="">All roles</option>
            <option value="Admin">Admin</option>
            <option value="User">User</option>
            <option value="Moderator">Moderator</option>
        </select>
    </div>
    <div class="table-wrap">
        <table id="userTable">
            <thead>
            <tr>
                <th>User</th><th>Username</th><th>Phone</th><th>Role</th><th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (users == null || users.isEmpty()) { %>
            <tr><td colspan="5"><div class="empty">No users found. <a href="register.jsp" style="color:var(--accent)">Register the first one.</a></div></td></tr>
            <% } else {
                String[] avClasses = {"av0","av1","av2","av3","av4"};
                int i = 0;
                for (User u : users) {
                    String initials = "";
                    if (u.getFirstName() != null && !u.getFirstName().isEmpty()) initials += u.getFirstName().charAt(0);
                    if (u.getLastName() != null && !u.getLastName().isEmpty()) initials += u.getLastName().charAt(0);
                    String av = avClasses[i % 5];
                    String roleLower = u.getRole() != null ? u.getRole().toLowerCase() : "user";
            %>
            <tr data-search="<%= (u.getFirstName()+" "+u.getLastName()+" "+u.getEmail()+" "+u.getUsername()).toLowerCase() %>"
                data-role="<%= u.getRole() %>">
                <td>
                    <div class="user-cell">
                        <div class="avatar <%= av %>"><%= initials.toUpperCase() %></div>
                        <div>
                            <div class="user-name"><%= u.getFirstName() %> <%= u.getLastName() %></div>
                            <div class="user-email"><%= u.getEmail() %></div>
                        </div>
                    </div>
                </td>
                <td><code style="font-size:0.8rem;background:var(--surface);padding:2px 6px;border-radius:4px;"><%= u.getUsername() %></code></td>
                <td style="color:var(--muted);"><%= u.getPhone() != null ? u.getPhone() : "—" %></td>
                <td><span class="badge badge-<%= roleLower %>"><%= u.getRole() %></span></td>
                <td>
                    <div class="actions">
                        <a href="search.jsp?username=<%= u.getUsername() %>" class="btn-action">Edit</a>
                        <form action="UserServlet" method="post" style="display:inline;" onsubmit="return confirm('Delete <%= u.getUsername() %>?')">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="username" value="<%= u.getUsername() %>"/>
                            <button type="submit" class="btn-action btn-delete">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <% i++; } } %>
            </tbody>
        </table>
    </div>
</main>
<script>
    function filterTable() {
        const q = document.getElementById('searchInput').value.toLowerCase();
        const role = document.getElementById('roleFilter').value;
        document.querySelectorAll('#userTable tbody tr[data-search]').forEach(row => {
            const matchSearch = !q || row.dataset.search.includes(q);
            const matchRole = !role || row.dataset.role === role;
            row.style.display = matchSearch && matchRole ? '' : 'none';
        });
    }
</script>
</body>
</html>