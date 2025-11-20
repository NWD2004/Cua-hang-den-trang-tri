<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.NguoiDung" %>
<style>
    .pc-h-dropdown {
        border: none;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        border-radius: 12px;
        overflow: hidden;
    }
    
    .dropdown-user-profile .dropdown-header {
        background: linear-gradient(135deg, #3f4d67 0%, #53668a 100%) !important;
        padding: 1.5rem;
        border-bottom: none;
    }
    
    .dropdown-user-profile .dropdown-body {
        background: #ffffff;
        padding: 0;
    }
    
    .profile-notification-scroll {
        padding: 1rem 0;
    }
    
    .dropdown-item {
        padding: 0.75rem 1.5rem;
        color: #4a5568;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        border: none;
    }
    
    .dropdown-item:hover {
        background-color: #f7fafc;
        color: #3f4d67;
    }
    
    .pc-icon {
        width: 20px;
        height: 20px;
    }
    
    .dropdown-item span {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .btn-primary {
        background: linear-gradient(135deg, #3f4d67 0%, #53668a 100%);
        border: none;
        border-radius: 8px;
        padding: 0.75rem 1.5rem;
        font-weight: 500;
        transition: all 0.3s ease;
        margin: 0 1rem;
    }
    
    .btn-primary:hover {
        background: linear-gradient(135deg, #2c384d 0%, #3f4d67 100%);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(63, 77, 103, 0.3);
    }
</style>

<header class="pc-header">
  <div class="header-wrapper flex max-sm:px-[15px] px-[25px] grow"><!-- [Mobile Media Block] start -->
<div class="me-auto pc-mob-drp">
  <ul class="inline-flex *:min-h-header-height *:inline-flex *:items-center">
    <!-- ======= Menu collapse Icon ===== -->
    <li class="pc-h-item pc-sidebar-collapse max-lg:hidden lg:inline-flex">
      <a href="#" class="pc-head-link ltr:!ml-0 rtl:!mr-0" id="sidebar-hide">
        <i data-feather="menu"></i>
      </a>
    </li>
    <li class="pc-h-item pc-sidebar-popup lg:hidden">
      <a href="#" class="pc-head-link ltr:!ml-0 rtl:!mr-0" id="mobile-collapse">
        <i data-feather="menu"></i>
      </a>
    </li>
  </ul>
</div>
<!-- [Mobile Media Block end] -->
<div class="ms-auto">
  <ul class="inline-flex *:min-h-header-height *:inline-flex *:items-center">
    <li class="dropdown pc-h-item">
      <a class="pc-head-link dropdown-toggle me-0" data-pc-toggle="dropdown" href="#" role="button"
        aria-haspopup="false" aria-expanded="false">
        <i data-feather="sun"></i>
      </a>
      <div class="dropdown-menu dropdown-menu-end pc-h-dropdown">
        <a href="#!" class="dropdown-item" onclick="layout_change('dark')">
          <i data-feather="moon"></i>
          <span>Dark</span>
        </a>
        <a href="#!" class="dropdown-item" onclick="layout_change('light')">
          <i data-feather="sun"></i>
          <span>Light</span>
        </a>
        <a href="#!" class="dropdown-item" onclick="layout_change_default()">
          <i data-feather="settings"></i>
          <span>Default</span>
        </a>
      </div>
    </li>
    
    <li class="dropdown pc-h-item header-user-profile">
      <a class="pc-head-link dropdown-toggle arrow-none me-0" data-pc-toggle="dropdown" href="#" role="button"
        aria-haspopup="false" data-pc-auto-close="outside" aria-expanded="false">
        <i data-feather="user"></i>
      </a>
      <div class="dropdown-menu dropdown-user-profile dropdown-menu-end pc-h-dropdown p-0 overflow-hidden">
        <div class="dropdown-header flex items-center justify-between py-4 px-5">
          <div class="flex mb-1 items-center">
            <div class="shrink-0">
              <img src="../assets/images/user/avatar-2.jpg" alt="user-image" class="w-10 rounded-full" />
            </div>
            <div class="grow ms-3">
              <%-- Hiển thị tên và email người dùng đăng nhập --%>
              <h6 class="mb-1 text-white">
                <% if (request.getAttribute("user") != null) { %>
                  <%= ((Model.NguoiDung)request.getAttribute("user")).getTenDangNhap() %>
                <% } else if (session != null && session.getAttribute("user") != null) { %>
                  <%= ((Model.NguoiDung)session.getAttribute("user")).getTenDangNhap() %>
                <% } else { %>
                  Chưa đăng nhập
                <% } %>
              </h6>
              <span class="text-white">
                <% if (request.getAttribute("user") != null) { %>
                  <%= ((Model.NguoiDung)request.getAttribute("user")).getEmail() %>
                <% } else if (session != null && session.getAttribute("user") != null) { %>
                  <%= ((Model.NguoiDung)session.getAttribute("user")).getEmail() %>
                <% } %>
              </span>
            </div>
          </div>
        </div>
        <div class="dropdown-body">
          <div class="profile-notification-scroll position-relative" style="max-height: calc(100vh - 225px)">
            <a href="../elements/AccountInfo.jsp" class="dropdown-item">
              <span>
                <svg class="pc-icon text-muted me-2 inline-block">
                  <use xlink:href="#custom-setting-outline"></use>
                </svg>
                <span>Settings</span>
              </span>
            </a>
            <a href="#" class="dropdown-item">
              <span>
                <svg class="pc-icon text-muted me-2 inline-block">
                  <use xlink:href="#custom-share-bold"></use>
                </svg>
                <span>Share</span>
              </span>
            </a>
            <a href="#" class="dropdown-item">
              <span>
                <svg class="pc-icon text-muted me-2 inline-block">
                  <use xlink:href="#custom-lock-outline"></use>
                </svg>
                <span>Change Password</span>
              </span>
            </a>
            <div class="grid my-3">
              <form id="logoutForm" action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                <button type="submit" class="btn btn-primary flex items-center justify-center">
                  <svg class="pc-icon me-2 w-[22px] h-[22px]">
                    <use xlink:href="#custom-logout-1-outline"></use>
                  </svg>
                  Đăng xuất
                </button>
              </form>
            </div>
            </div>
          </div>
        </div>
      </div>
    </li>
  </ul>
</div></div>
</header>

