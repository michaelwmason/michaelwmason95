import { Injectable } from '@angular/core'
import { BehaviorSubject } from 'rxjs'

@Injectable()
export class NavigationService {
    currentLocation$ = new BehaviorSubject<string>('home')

    constructor() {}

    updateLocation(location: string): void {
        this.currentLocation$.next(location)
    }
}
