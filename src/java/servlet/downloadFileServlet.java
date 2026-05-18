package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class downloadFileServlet extends HttpServlet {

    // This matches the same folder used in SaveLeaveAppServlet
    private static final String FILE_DIR = "uploadFiles";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("file");
        if (fileName == null || fileName.isEmpty()) {
            response.setContentType("text/plain");
            response.getWriter().println("Invalid file name.");
            return;
        }

        // Get the real path to uploadFiles directory
        String uploadPath = getServletContext().getRealPath("") + File.separator + FILE_DIR;
        File file = new File(uploadPath, fileName);

        if (!file.exists()) {
            response.setContentType("text/plain");
            response.getWriter().println("File not found.");
            return;
        }

        // Set response headers
        response.setContentType(getServletContext().getMimeType(fileName));
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setContentLengthLong(file.length());

        // Write file to output stream
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
