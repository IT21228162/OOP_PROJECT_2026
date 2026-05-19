<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.usermgmt.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Search & Update — UserVault</title>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --navy: #0d1b3e; --accent: #4f8ef7; --surface: #f5f7fb;
            --white: #ffffff; --border: #e2e8f0; --text: #1e293b;
            --muted: #64748b; --radius: 12px; --radius-sm: 8px;
        }
        body { font-family: 'DM Sans', sans-serif; background: var(--surface); min-height: 100vh; }
        nav { background: var(--navy); padding: 0 2rem; height: 60px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; }
        .brand { font-family: 'Sora', sans-serif; font-weight: 600; font-size: 1.15rem; color: #fff; display: flex; align-items: center; gap: 8px; text-decoration: none; }
        .brand-icon { width: 28px; height: 28px; background: var(--accent); border-radius: 6px; display: flex; align-items: center; justify-content: center; font-size: 14px; color: #fff; font-weight: 700; }
        .nav-links { display: flex; gap: 4px; }
        .nav-link { padding: 6px 14px; border-radius: var(--radius-sm); color: rgba(255,255,255,0.7); font-size: 0.875rem; text-decoration: none; }
        .nav-link.active { background: var(--accent); color: #fff; }
        main { max-width: 900px; margin: 0 auto; padding: 2.5rem 1.5rem; display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; }
        .full-row { grid-column: 1 / -1; }
        .page-title { font-family: 'Sora', sans-serif; font-size: 1.4rem; font-weight: 600; color: var(--text); }
        .page-subtitle { font-size: 0.85rem; color: var(--muted); margin-top: 3px; }
        .card { background: var(--white); border: 1px solid var(--border); border-radius: var(--radius); padding: 1.75rem; }
        .card-title { font-family: 'Sora', sans-serif; font-size: 0.95rem; font-weight: 600; color: var(--text); margin-bottom: 1.25rem; }
        label { display: block; font-size: 0.78rem; font-weight: 500; color: var(--text); margin-bottom: 6px; text-transform: uppercase; }
        input, select { width: 100%; padding: 9px 13px; border: 1px solid var(--border); border-radius: var(--radius-sm); font-family: 'DM Sans', sans-serif; font-size: 0.875rem; color: var(--text); background: var(--surface); outline: none; }
        input:focus, select:focus { border-color: var(--accent); box-shadow: 0 0 0 3px rgba(79,142,247,.15); background: #fff; }
        .form-group { margin-bottom: 1rem; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 0.875rem; }
        .btn { padding: 9px 18px; border-radius: var(--radius-sm); border: none; cursor: pointer; font-family: 'Sora', sans-serif; font-size: 0.85rem; font-weight: 600; width: 100%; }
        .btn-primary { background: var(--accent); color: #fff; }
        .btn-success { background: #10b981; color: #fff; }
        .result-profile { display: flex; align-items: center; gap: 14px; margin-bottom: 1.25rem; padding-bottom: 1.25rem; border-bottom: 1px solid var(--border); }
        .avatar-lg { width: 52px; height: 52px; border-radius: 50%; background: #dbeafe; color: #1e40af; display: flex; align-items: center; justify-content: center; font-family: 'Sora', sans-serif; font-size: 1rem; font-weight: 600; flex-shrink: 0; }
        .result-name { font-family: 'Sora', sans-serif; font-size: 1.05rem; font-weight: 600; color: var(--text); }
        .result-email { font-size: 0.8rem; color: var(--muted); margin-top: 2px; }
        .badge { display: inline-flex; padding: 2px 10px; border-radius: 20px; font-size: 0.7rem; font-weight: 600; margin-top: 4px; }
        .badge-admin { background: #ede9fe; color: #5b21b6; }
        .badge-user { background: #dbeafe; color: #1e40af; }
        .badge-moderator { background: #d1fae5; color: #065f46; }
        .alert { padding: 11px 14px; border-radius: var(--radius-sm); font-size: 0.875rem; margin-bottom: 1rem; }
        .alert-success { background: #d1fae5; color: #065f46; border: 1px solid #6ee7b7; }
        .alert-danger { background: #fee2e2; color: #7f1d1d; border: 1px solid #fca5a5; }
        .not-found { text-align: center; padding: 2.5rem 1rem; color: var(--muted); }
        .field-row { display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid var(--border); font-size: 0.85rem; }
        .field-row:last-child { border-bottom: none; }
        .field-label { color: var(--muted); }
        .field-value { color: var(--text); font-weight: 500; }
        @media (max-width: 680px) { main { grid-template-columns: 1fr; } .form-row { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
<nav>
    <a href="index.jsp" class="brand"><div class="brand-icon">U</div>UserVault</a>
    <div class="nav-links">
        <a href="register.jsp" class="nav-link">Register</a>
        <a href="UserServlet?action=list" class="nav-link">All Users</a>
        <a href="search.jsp" class="nav-link active">Search</a>
    </div>
</nav>
<main>
    <div class="full-row">
        <div class="page-title">Search &amp; update users</div>
        <div class="page-subtitle">Find a user by username, then view or edit their details.</div>
    </div>

    <% String success = (String) request.getAttribute("success");
        String error = (String) request.getAttribute("error");
        if (success != null) { %>
    <div class="full-row alert alert-success"><%= success %></div>
    <% } else if (error != null) { %>
    <div class="full-row alert alert-danger"><%= error %></div>
    <% } %>

    <div class="card">
        <div class="card-title">Find user</div>
        <form action="UserServlet" method="get">
            <input type="hidden" name="action" value="search"/>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="e.g. johnsmith01"
                       value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>"/>
            </div>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <% User found = (User) request.getAttribute("foundUser");
        boolean searched = request.getAttribute("searched") != null;
    %>

    <% if (found != null) {
        String initials = "";
        if (found.getFirstName() != null && !found.getFirstName().isEmpty()) initials += found.getFirstName().charAt(0);
        if (found.getLastName() != null && !found.getLastName().isEmpty()) initials += found.getLastName().charAt(0);
        String roleLower = found.getRole() != null ? found.getRole().toLowerCase() : "user";
    %>
    <div class="card">
        <div class="card-title">Edit user</div>
        <div class="result-profile">
            <div class="avatar-lg"><%= initials.toUpperCase() %></div>
            <div>
                <div class="result-name"><%= found.getFirstName() %> <%= found.getLastName() %></div>
                <div class="result-email"><%= found.getEmail() %></div>
                <span class="badge badge-<%= roleLower %>"><%= found.getRole() %></span>
            </div>
        </div>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="originalUsername" value="<%= found.getUsername() %>"/>
            <div class="form-row">
                <div class="form-group">
                    <label>First name</label>
                    <input type="text" name="firstName" value="<%= found.getFirstName() %>" required/>
                </div>
                <div class="form-group">
                    <label>Last name</label>
                    <input type="text" name="lastName" value="<%= found.getLastName() %>" required/>
                </div>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="<%= found.getEmail() %>" required/>
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="tel" name="phone" value="<%= found.getPhone() != null ? found.getPhone() : "" %>"/>
            </div>
            <div class="form-group">
                <label>Role</label>
                <select name="role">
                    <option value="User" <%= "User".equals(found.getRole()) ? "selected" : "" %>>User</option>
                    <option value="Admin" <%= "Admin".equals(found.getRole()) ? "selected" : "" %>>Admin</option>
                    <option value="Moderator" <%= "Moderator".equals(found.getRole()) ? "selected" : "" %>>Moderator</option>
                </select>
            </div>
            <div class="form-group">
                <label>New password <span style="color:var(--muted);font-size:0.7rem;text-transform:none;">(leave blank to keep current)</span></label>
                <input type="password" name="password" placeholder="Enter new password…"/>
            </div>
            <button type="submit" class="btn btn-success">Save changes</button>
        </form>
    </div>

    <div class="card full-row">
        <div class="card-title" style="margin-bottom:0.75rem;">Account details</div>
        <div class="field-row"><span class="field-label">Username</span><code><%= found.getUsername() %></code></div>
        <div class="field-row"><span class="field-label">Full name</span><span class="field-value"><%= found.getFirstName() %> <%= found.getLastName() %></span></div>
        <div class="field-row"><span class="field-label">Email</span><span class="field-value"><%= found.getEmail() %></span></div>
        <div class="field-row"><span class="field-label">Phone</span><span class="field-value"><%= found.getPhone() != null ? found.getPhone() : "—" %></span></div>
        <div class="field-row"><span class="field-label">Role</span><span class="badge badge-<%= roleLower %>"><%= found.getRole() %></span></div>
    </div>

    <% } else if (searched) { %>
    <div class="card">
        <div class="not-found">
            <div style="font-size:2rem;margin-bottom:8px">🔍</div>
            <div style="font-weight:500;color:var(--text);margin-bottom:4px;">No user found</div>
            <div style="font-size:0.82rem;">Try a different username.</div>
        </div>
    </div>
    <% } else { %>
    <div class="card">
        <div class="not-found">
            <div style="font-size:2rem;margin-bottom:8px">👈</div>
            <div style="font-weight:500;color:var(--text);margin-bottom:4px;">Search for a user</div>
            <div style="font-size:0.82rem;">Enter a username on the left to get started.</div>
        </div>
    </div>
    <% } %>
</main>
</body>
</html>