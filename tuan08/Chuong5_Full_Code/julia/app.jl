# Chạy từ thư mục gói: julia --project=julia julia/app.jl [cổng]
# Máy chủ cục bộ, chỉ dành cho một người học; không đưa lên Internet.
using HTTP, JSON3, Random
include("CauTruc.jl")
include("BaiLam.jl")
include("DichVu.jl")
using .DichVu

function main()
    port = isempty(ARGS) ? 8001 : tryparse(Int, ARGS[1])
    if port === nothing || !(1024 <= port <= 65535)
        error("Cổng phải là số nguyên trong 1024..65535.")
    end
    web = normpath(joinpath(@__DIR__, "..", "web"))
    isfile(joinpath(web, "index.html")) || error("Thiếu thư mục web. Giải nén toàn bộ gói.")
    static = Dict("/" => ("index.html", "text/html; charset=utf-8"),
                  "/style.css" => ("style.css", "text/css; charset=utf-8"),
                  "/app.js" => ("app.js", "text/javascript; charset=utf-8"))
    app = UngDung()
    guard = ReentrantLock()
    token = bytes2hex(rand(Random.RandomDevice(), UInt8, 32))
    hosts = Set(["127.0.0.1:$port", "localhost:$port"])
    origins = Set(["http://127.0.0.1:$port", "http://localhost:$port"])

    function response(status, body, mime)
        headers = ["Content-Type" => mime, "Cache-Control" => "no-store",
                   "X-Content-Type-Options" => "nosniff", "X-Frame-Options" => "DENY",
                   "Content-Security-Policy" => "default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data:; connect-src 'self'; frame-ancestors 'none'; base-uri 'none'"]
        return HTTP.Response(status, headers, body)
    end
    json_response(status, d) = response(status, JSON3.write(d), "application/json; charset=utf-8")
    failure(status, msg) = json_response(status, Dict("ok" => false, "message" => msg))

    function handler(req::HTTP.Request)
        HTTP.header(req, "Host", "") in hosts || return failure(403, "Host không hợp lệ.")
        path = first(split(String(req.target), '?'; limit=2))
        if req.method == "GET"
            if path == "/api/state"
                state = lock(guard) do
                    trang_thai(app)
                end
                return json_response(200, Dict("ok" => true, "state" => state, "token" => token))
            elseif path == "/favicon.ico"
                return response(204, "", "image/x-icon")
            elseif haskey(static, path)
                name, mime = static[path]
                return response(200, read(joinpath(web, name)), mime)
            end
            return failure(404, "Không tìm thấy đường dẫn.")
        elseif req.method == "POST" && path == "/api/action"
            if !(HTTP.header(req, "Origin", "") in origins) || HTTP.header(req, "X-Lab-Token", "") != token
                return failure(403, "Tải lại trang từ địa chỉ máy chủ cục bộ.")
            end
            startswith(HTTP.header(req, "Content-Type", ""), "application/json") || return failure(415, "Cần dữ liệu JSON.")
            length(req.body) <= 16384 || return failure(413, "Yêu cầu quá dài.")
            local d
            try
                d = JSON3.read(String(req.body), Dict{String,Any})
            catch
                return failure(400, "JSON không hợp lệ; cần một đối tượng.")
            end
            try
                value = lock(guard) do
                    thuc_hien!(app, d)
                end
                return json_response(200, value)
            catch e
                if e isa BaiLam.ChuaHoanThanh
                    return failure(422, e.msg)
                elseif e isa ArgumentError
                    return failure(400, e.msg)
                end
                return failure(500, "Lỗi trong mã: $(typeof(e)). Kiểm tra hàm vừa sửa và chạy bộ kiểm thử.")
            end
        end
        return failure(405, "Phương thức không được hỗ trợ.")
    end
    println("Julia: http://127.0.0.1:$port")
    println("Mở địa chỉ trên trong trình duyệt. Giữ terminal mở. Dừng bằng Ctrl+C.")
    try
        HTTP.serve(handler, "127.0.0.1", port; verbose=false, readtimeout=10)
    catch e
        if e isa InterruptException
            println("Đã dừng máy chủ.")
        else
            rethrow()
        end
    end
end
main()
