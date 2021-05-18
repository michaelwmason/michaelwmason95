import { Component, OnInit } from '@angular/core'
import { Location } from 'src/app/models/location'
import { NavigationService } from 'src/app/services/navigation/navigation.service'

@Component({
    templateUrl: './about-me.component.html',
    styleUrls: ['./about-me.component.scss'],
})
export class AboutMeComponent implements OnInit {
    constructor(private navigationService: NavigationService) {}

    ngOnInit(): void {
        this.navigationService.currentLocation$.next(Location.ABOUT_ME)
    }
}
