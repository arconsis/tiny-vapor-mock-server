import Vapor

func routes(_ app: Application) throws {
    app.get("**", use: captchaAll(req:))
    app.get(use: captchaAll(req:))
}

func captchaAll(req: Request) async throws -> String {
    let filename = FilenameObject(with: req.url)
    let byteBuffer = try await req.fileio.collectFile(at: filename.sourcePath)
    return String(buffer: byteBuffer)
}

// http://127.0.0.1/path/to/a/file -> /path/to/a/file.json => DONE!!!!
// http://127.0.0.1/path/to/a/file?amount=10&page=1 -> /path/to/a/file/amount=10.json
// http://127.0.0.1/path/to/a/file?page=1&amount=10 -> /path/to/a/file/amount=10.json
// {baseUrl}/movie/list -> /movie/list.json

