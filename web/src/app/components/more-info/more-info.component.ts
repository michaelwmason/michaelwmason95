import { Component, OnInit } from '@angular/core'
import { Location } from 'src/app/models/location'
import { NavigationService } from 'src/app/services/navigation/navigation.service'

@Component({
    templateUrl: './more-info.component.html',
    styleUrls: ['./more-info.component.scss'],
})
export class MoreInfoComponent implements OnInit {
    constructor(private navigationService: NavigationService) {}

    ngOnInit(): void {
        this.navigationService.currentLocation$.next(Location.MORE_INFO)
    }
}
