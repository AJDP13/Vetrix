export interface PaginatedResponse<T> {
    items: T[];
    total: number;
    page: number;
    pageLimit: number;
    totalPages: number;
}