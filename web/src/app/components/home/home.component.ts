import { Component, OnInit } from '@angular/core'
import { Location } from 'src/app/models/location'
import { NavigationService } from 'src/app/services/navigation/navigation.service'

@Component({
    templateUrl: './home.component.html',
    styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements OnInit {
    constructor(private navigationService: NavigationService) {}

    ngOnInit(): void {
        this.navigationService.currentLocation$.next(Location.HOME)
    }
}
