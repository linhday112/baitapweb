<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm - Linh Room Web</title>
</head>
<body>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 15px;">
        <h2 style="color: #2c3e50; border-left: 4px solid #1a73e8; padding-left: 10px; margin: 0;">Danh Sách Sản Phẩm (Phân trang 6sp/trang)</h2>
        
        <!-- Bộ lọc sắp xếp sản phẩm -->
        <div style="display: flex; align-items: center; gap: 10px;">
            <span style="font-size: 14px; color: #555; font-weight: bold;">Sắp xếp theo:</span>
            <a href="${pageContext.request.contextPath}/product?page=1&sort=sold"
               style="padding: 6px 14px; border-radius: 20px; text-decoration: none; font-size: 13px; font-weight: bold; ${sort == 'sold' || empty sort ? 'background: #e67e22; color: white;' : 'background: #f0f0f0; color: #333;'}">
               🔥 Bán chạy nhất
            </a>
            <a href="${pageContext.request.contextPath}/product?page=1&sort=newest"
               style="padding: 6px 14px; border-radius: 20px; text-decoration: none; font-size: 13px; font-weight: bold; ${sort == 'newest' ? 'background: #1a73e8; color: white;' : 'background: #f0f0f0; color: #333;'}">
               🆕 Mới nhất
            </a>
            <span style="color: #666; font-size: 14px; margin-left: 10px;">Tổng: <strong>${totalCount}</strong> sản phẩm</span>
        </div>
    </div>

    <!-- Danh sách sản phẩm 6sp / trang (Yêu cầu 4.3) -->
    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; margin-bottom: 35px;">
        <c:forEach var="p" items="${products}">
            <div style="background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.06); display: flex; flex-direction: column; border: 1px solid #eee;">
                <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="text-decoration: none;">
                    <img src="${p.getImageUrl(pageContext.request.contextPath)}" alt="${p.name}" style="width: 100%; height: 200px; object-fit: cover;" />
                </a>
                <div style="padding: 18px; display: flex; flex-direction: column; flex: 1;">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span style="font-size: 12px; color: #1a73e8; font-weight: bold; text-transform: uppercase;">${p.category != null ? p.category.name : 'Danh mục'}</span>
                        <span style="font-size: 12px; color: #27ae60; background: #e8f8f5; padding: 2px 8px; border-radius: 10px; font-weight: bold;">Đã bán: ${p.sold}</span>
                    </div>
                    <h3 style="margin: 8px 0; font-size: 17px; color: #2c3e50; line-height: 1.4; height: 46px; overflow: hidden;">
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="text-decoration: none; color: inherit;">${p.name}</a>
                    </h3>
                    <p style="color: #777; font-size: 13px; margin-bottom: 15px; height: 38px; overflow: hidden;">${p.description != null ? p.description : 'Không có mô tả sản phẩm'}</p>
                    
                    <div style="margin-top: auto; display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #f0f0f0; padding-top: 12px;">
                        <span style="color: #e74c3c; font-size: 18px; font-weight: bold;">
                            <fmt:formatNumber value="${p.price}" pattern="#,###" /> VNĐ
                        </span>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" style="padding: 8px 16px; background: #1a73e8; color: white; text-decoration: none; border-radius: 5px; font-size: 13px; font-weight: bold;">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Thanh chuyển trang (Pagination Controls) -->
    <c:if test="${totalPages > 1}">
        <div style="display: flex; justify-content: center; gap: 8px; margin: 30px 0;">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}&sort=${sort}" style="padding: 8px 14px; background: white; border: 1px solid #ddd; color: #333; text-decoration: none; border-radius: 4px;">&laquo; Trước</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span style="padding: 8px 14px; background: #1a73e8; color: white; border: 1px solid #1a73e8; border-radius: 4px; font-weight: bold;">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/product?page=${i}&sort=${sort}" style="padding: 8px 14px; background: white; border: 1px solid #ddd; color: #333; text-decoration: none; border-radius: 4px;">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}&sort=${sort}" style="padding: 8px 14px; background: white; border: 1px solid #ddd; color: #333; text-decoration: none; border-radius: 4px;">Sau &raquo;</a>
            </c:if>
        </div>
    </c:if>

</body>
</html>