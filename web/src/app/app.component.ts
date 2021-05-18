import { Component, OnDestroy, OnInit } from '@angular/core'
import { FormBuilder, FormControl, FormGroup } from '@angular/forms'
import { ActivatedRoute } from '@angular/router'
import { Observable, Subscription } from 'rxjs'
import { map } from 'rxjs/operators'
import { Location } from './models/location'
import { NavigationService } from './services/navigation/navigation.service'

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit, OnDestroy {
    form: FormGroup
    subs: Subscription[] = []
    constructor() {}

    ngOnInit(): void {}

    ngOnDestroy(): void {
        this.subs.forEach((s) => s.unsubscribe())
    }
}
