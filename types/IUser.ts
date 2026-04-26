export interface IUser{
    id: string,
    name: string,
    lastname: string,
    passwordSHA256?: string,
    type: number,
    identificationType: number,
    active: boolean
}