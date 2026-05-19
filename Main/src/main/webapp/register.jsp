<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register — UserVault</title>
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
<body class="bg-slate-50 font-sans min-h-screen flex flex-col">

<!-- Navbar -->
<nav class="bg-navy h-14 flex items-center justify-between px-6 sticky top-0 z-10">
    <a href="index.jsp" class="flex items-center gap-2 no-underline">
        <span class="font-sora font-semibold text-white text-base">UserVault</span>
    </a>
    <div class="flex gap-1">
        <a href="register.jsp" class="px-3 py-1.5 rounded-md bg-accent text-white text-sm no-underline">Register</a>
        <a href="UserServlet?action=list" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">All users</a>
        <a href="search.jsp" class="px-3 py-1.5 rounded-md text-white/70 text-sm no-underline hover:text-white hover:bg-white/10 transition-colors">Search</a>
    </div>
</nav>

<!-- Main -->
<main class="flex-1 flex justify-center items-start px-4 py-10">
    <div class="bg-white border border-slate-200 rounded-xl p-8 w-full max-w-md shadow-sm">

        <div class="mb-6">
            <h1 class="font-sora text-xl font-semibold text-slate-800 mb-1">Create new user</h1>
            <p class="text-sm text-slate-500">Fill in the details below to register a new user account.</p>
        </div>

        <% String success=(String)request.getAttribute("success"); String error=(String)request.getAttribute("error");
            if(success!=null){ %>
        <div class="bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-lg px-4 py-3 text-sm mb-5"><%= success %></div>
        <% } else if(error!=null){ %>
        <div class="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm mb-5"><%= error %></div>
        <% } %>

        <form action="UserServlet" method="post" class="space-y-4">
            <input type="hidden" name="action" value="create"/>

            <!-- First / Last name -->
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">First name</label>
                    <input type="text" name="firstName" placeholder="John" required
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>
                <div>
                    <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Last name</label>
                    <input type="text" name="lastName" placeholder="Smith" required
                           class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                </div>
            </div>

            <!-- Email -->
            <div>
                <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Email address</label>
                <input type="email" name="email" placeholder="john@example.com" required
                       class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
            </div>

            <!-- Phone -->
            <div>
                <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Phone number</label>
                <input type="tel" name="phone" placeholder="+94 77 123 4567"
                       class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
            </div>

            <!-- Role -->
            <div>
                <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Role</label>
                <select name="role"
                        class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-700 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition">
                    <option>User</option>
                    <option>Admin</option>
                    <option>Moderator</option>
                </select>
            </div>

            <hr class="border-slate-100"/>

            <!-- Username -->
            <div>
                <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Username</label>
                <input type="text" name="username" placeholder="johnsmith01" required
                       class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
            </div>

            <!-- Password + strength -->
            <div>
                <label class="block text-xs font-medium text-slate-500 uppercase tracking-wide mb-1.5">Password</label>
                <input type="password" name="password" placeholder="Min. 6 characters" required
                       oninput="checkStrength(this.value)"
                       class="w-full px-3 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 bg-slate-50 focus:outline-none focus:ring-2 focus:ring-accent/30 focus:border-accent focus:bg-white transition"/>
                <!-- Strength bar -->
                <div class="mt-2 h-1 rounded-full bg-slate-100 overflow-hidden">
                    <div id="strengthFill" class="h-full w-0 rounded-full transition-all duration-300"></div>
                </div>
                <p id="pwdHint" class="text-xs text-slate-400 mt-1.5">Enter a password</p>
            </div>

            <button type="submit"
                    class="w-full py-2.5 bg-accent hover:bg-blue-500 text-white font-sora font-semibold text-sm rounded-lg transition-colors">
                Create account
            </button>
        </form>
    </div>
</main>

<script>
    function checkStrength(val) {
        const fill = document.getElementById('strengthFill');
        const hint = document.getElementById('pwdHint');
        if (!val) { fill.style.width = '0'; hint.textContent = 'Enter a password'; hint.style.color = '#94a3b8'; return; }
        let score = 0;
        if (val.length >= 6)  score++;
        if (val.length >= 10) score++;
        if (/[0-9]/.test(val)) score++;
        if (/[^a-zA-Z0-9]/.test(val)) score++;
        const colors  = ['#ef4444','#f97316','#eab308','#10b981'];
        const labels  = ['Too short','Weak','Good','Strong'];
        const widths  = ['25%','50%','75%','100%'];
        const i = Math.min(score - 1, 3);
        fill.style.width      = widths[i]  || '15%';
        fill.style.background = colors[i]  || '#ef4444';
        hint.textContent      = labels[i]  || 'Too short';
        hint.style.color      = colors[i]  || '#ef4444';
    }
</script>
</body>
</html>