export interface loginData{
    id: number,
    passwordHash: string
}

export interface invoiceData{
    billableItem: number,
    currency: number,
    amout: string, 
    reference: string, 
    payerId: number
}

export interface userData extends newUser{
    uid: string
}