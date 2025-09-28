import Services

public extension Info {
    init(from response: InfoResponse) {
        self.next = response.next
        self.count = response.count
        self.pages = response.pages
        self.prev = response.prev
    }
}
