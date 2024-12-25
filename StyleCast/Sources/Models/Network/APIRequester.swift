import Foundation

struct OpenAPIRequester {

    private struct RequestBody: Encodable {
        let model: String
        let messages: [Message]
        let temperature: Float

        struct Message: Encodable {
            let role: String
            let content: String
        }
    }

    private struct APIResponse: Decodable {
        let choices: [Choice]

        struct Choice: Decodable {
            let message: Message

            struct Message: Decodable {
                let content: String
            }
        }
    }

    func postGPT(_ content: String) async throws -> String {
        var request = URLRequest(
            url: URL(string: "https://api.openai.com/v1/chat/completions")!
        )
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(APIKey.openAiApiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("\(APIKey.organizasionId)", forHTTPHeaderField: "OpenAI-Organization")
        request.httpBody = try JSONEncoder().encode(
            RequestBody(
                model: "gpt-3.5-turbo",
                messages: [RequestBody.Message(role: "user", content: content)],
                temperature: 1.0
            )
        )
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw APIClientError.networkError
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print(response as? HTTPURLResponse ?? "200じゃないです")
            throw APIClientError.responseError
        }
        guard let response = try? JSONDecoder().decode(APIResponse.self, from: data) else {
            throw APIClientError.decodeError
        }
        guard let content = response.choices.first?.message.content else {
            throw APIClientError.responseError
        }
        return content
    }
}

enum APIClientError: Error {
    case invalidURL
    case networkError
    case responseError
    case decodeError
    case unknown

    var title: String {
        switch self {
        case .invalidURL:
            return "無効なURLのエラー"
        case .networkError:
            return "ネットワークエラー"
        case .responseError:
            return "レスポンスエラー"
        case .decodeError:
            return "デコードエラー"
        default:
            return "不明なエラー"
        }
    }
}
