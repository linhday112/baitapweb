<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Linh Room Web</title>
</head>
<body>

    <!-- User Welcome Banner -->
    <div style="background: white; padding: 25px 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 30px;">
        <h2 style="color: #1a73e8; margin-bottom: 12px;">Chào mừng đến với Linh Room Web</h2>

        <div style="display: flex; align-items: center; gap: 20px; margin: 15px 0; padding: 15px; background: #f8fafc; border-radius: 8px;">
            <c:choose>
                <c:when test="${not empty sessionScope.account.images}">
                    <c:choose>
                        <c:when test="${sessionScope.account.images.startsWith('http')}">
                            <img src="${sessionScope.account.images}" alt="avatar" style="width: 70px; height: 70px; border-radius: 50%; object-fit: cover; border: 2px solid #1a73e8;" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.images}" alt="avatar" style="width: 70px; height: 70px; border-radius: 50%; object-fit: cover; border: 2px solid #1a73e8;" />
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <img src="https://via.placeholder.com/70?text=User" alt="avatar" style="width: 70px; height: 70px; border-radius: 50%; object-fit: cover;" />
                </c:otherwise>
            </c:choose>

            <div>
                <p style="font-size: 16px; margin-bottom: 4px;">Xin chào <strong>${sessionScope.account.fullName}</strong> (${sessionScope.account.username})</p>
                <p style="color: #666; font-size: 14px; margin-bottom: 4px;">Email: <strong>${sessionScope.account.email != null ? sessionScope.account.email : 'Chưa cập nhật'}</strong> | SĐT: <strong>${sessionScope.account.phone != null ? sessionScope.account.phone : 'Chưa cập nhật'}</strong></p>
                <p style="font-size: 13px;">Vai trò: <strong style="background: #e2e8f0; padding: 2px 8px; border-radius: 10px;">${sessionScope.account.role}</strong></p>
            </div>
        </div>

        <div style="display: flex; gap: 10px; margin-top: 15px;">
            <a href="${pageContext.request.contextPath}/profile" style="padding: 9px 18px; background: #1a73e8; color: white; text-decoration: none; border-radius: 5px; font-weight: 500;">Chỉnh sửa hồ sơ cá nhân</a>
            <a href="${pageContext.request.contextPath}/product" style="padding: 9px 18px; background: #28a745; color: white; text-decoration: none; border-radius: 5px; font-weight: 500;">Xem tất cả sản phẩm</a>
        </div>
    </div>

    <!-- Section 1: Top 10 Sản Phẩm Bán Chạy Nhất -->
    <div style="margin-top: 30px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3 style="color: #d35400; font-size: 20px; border-left: 4px solid #e67e22; padding-left: 10px; margin: 0;">🔥 Top 10 Sản Phẩm Bán Chạy Nhất</h3>
            <a href="${pageContext.request.contextPath}/product?sort=sold" style="color: #e67e22; text-decoration: none; font-weight: bold;">Xem tất cả top bán chạy &rarr;</a>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px;">
            <c:forEach var="p" items="${top10SoldProducts}" varStatus="status">
                <div style="background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); display: flex; flex-direction: column; position: relative;">
                    <!-- Badge Top Rank -->
                    <span style="position: absolute; top: 10px; left: 10px; background: #e67e22; color: white; padding: 3px 8px; border-radius: 12px; font-size: 11px; font-weight: bold; box-shadow: 0 2px 4px rgba(0,0,0,0.2);">
                        Top #${status.index + 1}
                    </span>
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="text-decoration: none; color: inherit;">
                        <img src="${p.getImageUrl(pageContext.request.contextPath)}" alt="${p.name}" style="width: 100%; height: 160px; object-fit: cover;" />
                    </a>
                    <div style="padding: 15px; display: flex; flex-direction: column; flex: 1;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 11px; color: #888; text-transform: uppercase; letter-spacing: 0.5px;">${p.category != null ? p.category.name : 'Danh mục'}</span>
                            <span style="font-size: 12px; color: #27ae60; font-weight: bold;">Đã bán: ${p.sold}</span>
                        </div>
                        <h4 style="margin: 6px 0; font-size: 15px; color: #333; line-height: 1.3; height: 38px; overflow: hidden;">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="text-decoration: none; color: #2c3e50;">${p.name}</a>
                        </h4>
                        <p style="color: #e74c3c; font-size: 16px; font-weight: bold; margin-top: auto;">
                            <fmt:formatNumber value="${p.price}" pattern="#,###" /> VNĐ
                        </p>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="display: block; text-align: center; padding: 8px; background: #fff3e0; color: #d35400; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: bold; margin-top: 8px;">Xem chi tiết</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Section 2: 10 Sản Phẩm Mới Nhất -->
    <div style="margin-top: 40px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3 style="color: #2c3e50; font-size: 20px; border-left: 4px solid #1a73e8; padding-left: 10px; margin: 0;">🆕 10 Sản Phẩm Mới Nhất</h3>
            <a href="${pageContext.request.contextPath}/product?sort=newest" style="color: #1a73e8; text-decoration: none; font-weight: bold;">Xem tất cả &rarr;</a>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px;">
            <c:forEach var="p" items="${top10Products}">
                <div style="background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); display: flex; flex-direction: column;">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="text-decoration: none; color: inherit;">
                        <img src="${p.getImageUrl(pageContext.request.contextPath)}" alt="${p.name}" style="width: 100%; height: 160px; object-fit: cover;" />
                    </a>
                    <div style="padding: 15px; display: flex; flex-direction: column; flex: 1;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 11px; color: #888; text-transform: uppercase; letter-spacing: 0.5px;">${p.category != null ? p.category.name : 'Danh mục'}</span>
                            <span style="font-size: 12px; color: #666;">Đã bán: ${p.sold}</span>
                        </div>
                        <h4 style="margin: 6px 0; font-size: 15px; color: #333; line-height: 1.3; height: 38px; overflow: hidden;">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="text-decoration: none; color: #2c3e50;">${p.name}</a>
                        </h4>
                        <p style="color: #e74c3c; font-size: 16px; font-weight: bold; margin-top: auto;">
                            <fmt:formatNumber value="${p.price}" pattern="#,###" /> VNĐ
                        </p>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="display: block; text-align: center; padding: 8px; background: #f0f4f9; color: #1a73e8; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: 500; margin-top: 8px;">Xem chi tiết</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>