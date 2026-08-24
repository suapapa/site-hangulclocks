# HangulClocks: 여러분의 한글시계

한글로 만든 시계 프로젝트를 모아 둔 갤러리입니다.

* [여러분의 한글시계 - 라이브 사이트](https://suapapa.github.io/site-hangulclocks)

## 시계 등록하기

직접 만든 한글시계나, 온라인에서 본 프로젝트를 등록할 수 있습니다.

1. `src/assets/hangulclocks.yaml`에 항목을 추가합니다. (제목, 제작자, 이미지, 링크, 카테고리, 태그, 설명)
2. PR 또는 이슈로 등록을 요청합니다.

## 주요 기능

- **실시간 인터랙티브 한글시계 (Live Hangul Clock)**: 히어로 영역에서 5x5 매트릭스로 현재 시간을 5분 단위의 한글로 표시하며(`rusty-hangulclock` 동작 방식 기반), 시간 탐색 슬라이더로 시간 시뮬레이션 지원.
- **카테고리 필터 및 실시간 검색**: 하드웨어, 공예, 웹/앱, DIY 등 카테고리별 탐색 및 다중 키워드/태그 실시간 필터링.

## 개발 및 기여

설치, 빌드, 배포(GitHub Actions 및 Docker) 방법은 [AGENTS.md](./AGENTS.md)를 참고하세요.

의존성은 `npm audit`로 점검합니다. 시계 카드 링크는 `https`만 허용하고, 이미지는 `src/assets`에 번들된 파일만 사용합니다.
