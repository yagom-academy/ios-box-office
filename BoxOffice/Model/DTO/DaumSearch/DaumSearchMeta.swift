//
//  DaumSearchMeta.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/06.
//

struct DaumSearchMeta: Decodable {
    let totalCount: Int     // 검색된 문서 수
    let pageableCount: Int  // 검색된 문서 수 중 노출 가능 문서 수
    let isEnd: Bool         // 현재 페이지가 마지막 페이지인지 여부, 값이 false면 page를 증가시켜 다음 페이지를 요청할 수 있음
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}
